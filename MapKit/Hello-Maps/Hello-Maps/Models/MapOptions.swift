//
//  MapOptions.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/7/23.
//

import Foundation
import MapKit
import SwiftUI

enum MapOptions: String, Identifiable, CaseIterable {
    case standard
    case hybird
    case imagery
    
    var id: String {
        self.rawValue
    }
    
    var mapStyle: MapStyle {
        switch self {
            case .standard:
                return .standard
            case .hybird:
                return .hybrid
            case .imagery:
                return .imagery
        }
    }
}
