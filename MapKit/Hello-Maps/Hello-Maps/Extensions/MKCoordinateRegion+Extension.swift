//
//  MKCoordinateRegion+Extension.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/7/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        if lhs.center.latitude == rhs.center.latitude && lhs.span.latitudeDelta == rhs.span.latitudeDelta && lhs.span.longitudeDelta == rhs.span.longitudeDelta {
            return true
        } else {
            return false
        }
    }
    
    static var coffee: MKCoordinateRegion {
        MKCoordinateRegion(center: .coffee, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
    
    static var restaurant: MKCoordinateRegion {
        MKCoordinateRegion(center: .restaurant, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
}
