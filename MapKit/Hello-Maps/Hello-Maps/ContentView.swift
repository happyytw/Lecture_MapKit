import SwiftUI
import MapKit // 1. 지도를 사용하려면 MapKit를 import해야한다.

enum DisplayMode {
    case list
    case detail
}

struct ContentView: View {
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)// 지도에서 카메라의 시선 설정
    @State private var locationManager = LocationManager.shared // 기존에는 StateObject를 사용했지만 @Observable 메크로를 사용하여 @State라고만 명시하면 된다.
    @State private var query: String = "Coffee"
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    @State private var selectedMapOption: MapOptions = .standard // 싱글톤
    @State private var isSearching: Bool = false
    @State private var mapItems: [MKMapItem] = []
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var selectedMapItem: MKMapItem?
    @State private var displayMode: DisplayMode = .list
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var route: MKRoute?

    
    // 경로를 계산하는 버튼을 눌렀을때
    private func requestCalculateDirections() async {
        route = nil
        
        if let selectedMapItem {
            guard let currentUserLocation = locationManager.manager.location else {
                return
            }
            let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate))
            
            // 경로를 계산해서 route 프로퍼티에 값을 쓴다 // 즉 이제 route를 화면에 띄우면 경로가 나타난다.
            self.route = await calculateDirections(from: startingMapItem, to: selectedMapItem)
           
        }
    }

    private func search() async {
        do {
            mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
            print(mapItems)
            isSearching = false
        } catch {
            mapItems = []
            print(error.localizedDescription)
            isSearching = false
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .top) { // layer,위 아래로 뷰를 설정할 수 있다.
            
            // position은 ios17에서 새로 생긴 것이다, 카메라의 위치를 설정할 수 있다.
            Map(position: $position, selection: $selectedMapItem) { // 지도 생성
                ForEach(mapItems, id: \.self) { mapItem in
                    Marker(item: mapItem)
                }
                
                if let route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
                
                
                UserAnnotation() // 내 위치 표현
                
                
            }
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    
                    switch displayMode {
                    case .list:
                        SearchBarView(search: $query, isSearching: $isSearching)
                        PlaceListView(mapItems: mapItems, selectedMapItem: $selectedMapItem)
                    case .detail:
                        SelectedPlaceDetailView(mapItem: $selectedMapItem)
                            .padding()
                        
                        if selectedDetent == .medium || selectedDetent == .large {
                            if let selectedMapItem  {
                                ActionButtons(mapItem: selectedMapItem)
                                    .padding()
                            }
                            LookAroundPreview(initialScene: lookAroundScene)
                        }
                    }
                    
                    
                    Spacer()
                }
                    // fraction:커스텀 높이, selection: selectedDetent의 값이 바뀌면 적용된다.
                    .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                    .presentationDragIndicator(.visible) // 드래그할 수 있는게 표시된다.
                    .interactiveDismissDisabled() // 사용자가 직업 없애는걸 막아준다.
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium)) // 중간 위로부터는 시트 뒤에 있는 배경과 상호작용이 가능해진다.
            })
            .onChange(of: locationManager.region, { oldValue, newValue in
                position = .region(locationManager.region) // 내 위치가 바뀌면 지도 시선 위치를 변경해준다.
            })
            .mapControls({
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
                
            })
            .mapStyle(selectedMapOption.mapStyle)
                .onChange(of: locationManager.region) { oldValue, newValue in
                    withAnimation {
                        position = .region(locationManager.region) // 카메라의 위치를 현재 싱글톤인 locationManager가 갖고있는 region으로 설정한다.
                    }
                }
        }
        .onChange(of: selectedMapItem, {
            if selectedMapItem != nil {
                displayMode = .detail
                // requestCalculateDirections()
            } else {
                displayMode = .list
            }
        })
        .onMapCameraChange { context in
            visibleRegion = context.region
        }
        .task(id: isSearching, { // isSearching이 변하면 수행된다
            if isSearching {
                await search()
            }
        })
        .task(id: selectedMapItem) { // selectedMapItem이 변경되면 실행된다.
            lookAroundScene = nil
            if let selectedMapItem {
                let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
                lookAroundScene = try? await request.scene
                await requestCalculateDirections()
            }
        }
    }
}

#Preview {
    ContentView()
}
