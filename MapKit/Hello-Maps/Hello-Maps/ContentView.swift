import SwiftUI
import MapKit // 1. 지도를 사용하려면 MapKit를 import해야한다.

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)// 지도에서 카메라의 시선이 어디로 가야하는지를 지정한다.
    @State private var locationManager = LocationManager.shared // 기존에는 StateObject를 사용했지만 @Observable 메크로를 사용하여 @State라고만 명시하면 된다.
    @State private var selectedMapOption: MapOptions = .standard
    @State private var query: String = ""
    @State private var selectedDetent: PresentationDetent = .fraction(0.15)
    
    var body: some View {
        
        ZStack(alignment: .top) { // layer,위 아래로 뷰를 설정할 수 있다.
            
            Map(position: $position) { // 지도 생성
                Annotation("Coffe", coordinate: .coffee) {
                    Image(systemName: "cup.and.saucer.fill")
                        .padding(4)
                        .foregroundStyle(.white)
                        .background(.indigo)
                        .clipShape(.circle)
                }
                
                Annotation("Restaurant", coordinate: .restaurant) {
                    Image(systemName: "fork.knife.circle")
                }
                
                UserAnnotation() // 내 위치 표현
                
            }
            .sheet(isPresented: .constant(true), content: {
                VStack {
                    TextField("Search", text: $query)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .onSubmit {
                            // code fired when you return in TextField
                        }
                    Spacer()
                }
                    .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent) // fraction:커스텀 높이
                    .presentationDragIndicator(.visible) // 드래그할 수 있는게 표시된다.
                    .interactiveDismissDisabled() // 사용자가 직업 없애는걸 막아준다.
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium)) // 중간 위로부터는 시트 뒤에 있는 배경과 상호작용이 가능해진다.
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
//            Picker("Map Styles", selection: $selectedMapOption) { // tag를 붙여야지 $selectedMapOption의 값이 그에 맞게 적용된다, MapOptions이 Identifiable 프로토콜을 따르고 있기 때문에, selection과 tag내부는 반드시 타입이 같아야한다.
//                ForEach(MapOptions.allCases) { mapOption in
//                    Text(mapOption.rawValue.capitalized).tag(mapOption)
//                }
//            }.pickerStyle(.segmented)
//                .background(.white)
//                .padding()
            
            VStack {
                Spacer()
                HStack {
                    Button("Coffee") {
                        withAnimation {
                            position = .region(.coffee)
                        }
                    }.buttonStyle(.borderedProminent)
                        .tint(.brown)
                    
                    Button("Restaurant") {
                        withAnimation {
                            position = .region(.restaurant)
                        }
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
