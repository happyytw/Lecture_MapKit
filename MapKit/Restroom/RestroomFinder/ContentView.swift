//
//  ContentView.swift
//  RestroomFinder
//
//  Created by Mohammad Azam on 8/25/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @Environment(\.httpClient) private var restroomClient
    @State private var locationManager = LocationManager.shared
    @State private var restrooms: [Restroom] = []
    @State private var selectedRestroom: Restroom?
    @State private var visibleRegion: MKCoordinateRegion?
    // 카메라의 시점을 결정하는 변수다
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    private func loadRestrooms() async {
        
        guard let region = visibleRegion else { return }
        let coordinate = region.center
        
        do {
            restrooms = try await restroomClient.fetchRestrooms(url: Constants.Urls.restroomsByLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        ZStack {
            Map(position: $position) { // 카메라의 시점을 결정
                ForEach(restrooms) { restroom in
                    Annotation(restroom.name, coordinate: restroom.coordinate) {
                        Text("🚻")
                            .scaleEffect(selectedRestroom == restroom ? 2.0 : 1.0)
                            .font(.title)
                            .onTapGesture {
                                withAnimation {
                                    selectedRestroom = restroom
                                }
                            }
                            .animation(.spring(duration: 0.25), value: selectedRestroom)
                    }
                }
                
                UserAnnotation()
            }
        }.task(id: locationManager.region) { // region이 바뀌게 되면 실행된다.
            print("region changed")
            if let region = locationManager.region {
                visibleRegion = region
                await loadRestrooms()
            }
        }
        .onMapCameraChange({ context in
            visibleRegion = context.region
        })
        .sheet(item: $selectedRestroom, content: { restroom in
            RestroomDetailView(restroom: restroom)
                .padding()
                .presentationDetents([.fraction(0.25)])
        })
        .overlay(alignment: .topLeading) {
            Button {
                Task {
                    await loadRestrooms()
                }
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white, .blue) // 위에 투명으로 뚫려 있는것을 막아준다
            }
        }
    }
}

#Preview {
    ContentView()
        // httpClient는 keyPath, RestroomClient()는 keyPath의 value
        .environment(\.httpClient, RestroomClient())
}
