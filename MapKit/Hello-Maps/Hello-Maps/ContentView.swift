import SwiftUI
import MapKit // 1. 지도를 사용하려면 MapKit를 import해야한다.

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)// 지도에서 카메라의 시선이 어디로 가야하는지를 지정한다.
    @State private var locationManager = LocationManager.shared // 기존에는 StateObject를 사용했지만 @Observable 메크로를 사용하여 @State라고만 명시하면 된다.
    @State private var selectedMapOption: MapOptions = .standard
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Map(position: $position) {
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
                
            }.mapStyle(selectedMapOption.mapStyle)
                .onChange(of: locationManager.region) { oldValue, newValue in
                    withAnimation {
                        position = .region(locationManager.region) // 카메라의 위치를 현재 싱글톤인 locationManager가 갖고있는 region으로 설정한다.
                    }
                }
            Picker("Map Styles", selection: $selectedMapOption) { // tag를 붙여야지 $selectedMapOption의 값이 그에 맞게 적용된다, MapOptions이 Identifiable 프로토콜을 따르고 있기 때문에, selection과 tag내부는 반드시 타입이 같아야한다.
                ForEach(MapOptions.allCases) { mapOption in
                    Text(mapOption.rawValue.capitalized).tag(mapOption)
                }
            }.pickerStyle(.segmented)
                .background(.white)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
