//
//  ActionButtons.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/23/23.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
    
    let mapItem: MKMapItem
    
    var body: some View {
        HStack {
            
            Button(action: {
                if let phone = mapItem.phoneNumber {
                    let numericPhoneNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined() // 숫자만 표기하도록 설정
                    makeCall(phone: numericPhoneNumber)
                }
            }, label: {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Call")
                }
            }).buttonStyle(.bordered)
            
            Button(action: {
                MKMapItem.openMaps(with: [mapItem]) // 애플맵을 열어서 경로를 안내한다
            }, label: {
                HStack {
                    Image(systemName: "car.circle.fill")
                    Text("Take me there")
                }
            }).buttonStyle(.bordered)
                .tint(.green)
            
            Spacer()
        }
    }
}

#Preview {
    ActionButtons(mapItem: PreViewData.apple)
}
