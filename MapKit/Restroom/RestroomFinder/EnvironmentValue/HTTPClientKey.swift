//
//  HTTPClientKey.swift
//  RestroomFinder
//
//  Created by Taewon Yoon on 10/23/23.
//

import Foundation
import SwiftUI

private struct HTTPClientKey: EnvironmentKey {
    static var defaultValue: HTTPClient = RestroomClient()
}

extension EnvironmentValues {
    
    var httpClient: HTTPClient {
        get { self[HTTPClientKey.self] }
        set { self[HTTPClientKey.self] = newValue }
    }
}
