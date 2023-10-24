//
//  PreViewData.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/17/23.
//

import Foundation
import MapKit
import Contacts

struct PreViewData {
    // HARD CODE
    static var apple: MKMapItem {
        let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        
        let addressDictionary: [String: Any] = [
            // 아래 있는 key들은 Contacts 프레임워크에 들어있는 것이다.
            CNPostalAddressStreetKey: "1 Infinite Loop",
            CNPostalAddressCityKey: "Cupertino",
            CNPostalAddressStateKey: "CA",
            CNPostalAddressPostalCodeKey: "95014",
            CNPostalAddressCountryKey: "United State"
        ]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Apple Inc."
        return mapItem
    }
}
