//
//  SelectedPlaceDetailView.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/22/23.
//

import SwiftUI
import MapKit

struct SelectedPlaceDetailView: View {
    // 세부 사항을 다 보고 닫고 싶을 때. 우리가 지도항목에 대한 바인딩을 전달할 이유는 우리가 이것을 nil로 할당할 것이기 때문
    @Binding var mapItem: MKMapItem?
    var body: some View {
        HStack(alignment: .top, content: {
            VStack(alignment: .leading, content: {
                if let mapItem {
                    PlaceView(mapItem: mapItem)
                }
            })
            
            Image(systemName: "xmark.circle.fill")
                .padding([.trailing], 10)
                .onTapGesture {
                    mapItem = nil
                }
        })
    }
}

#Preview {
    
    let apple = Binding<MKMapItem?>(get: { PreViewData.apple }, set: { _ in})
    SelectedPlaceDetailView(mapItem: apple)
    
    return SelectedPlaceDetailView(mapItem: apple)
}
