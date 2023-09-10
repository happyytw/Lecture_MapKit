//
//  HeaderModdel.swift
//  Avocados
//
//  Created by Taewon Yoon on 2023/09/10.
//

import SwiftUI

// MARK: - HEADER MODEL

struct Header: Identifiable {
    var id = UUID()
    var image: String
    var headline: String
    var subheadline: String
}
