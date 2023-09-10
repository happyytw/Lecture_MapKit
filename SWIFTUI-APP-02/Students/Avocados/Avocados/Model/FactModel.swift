//
//  FactModel.swift
//  Avocados
//
//  Created by Taewon Yoon on 2023/09/10.
//

import SwiftUI

// MARK: - FACT MODEL

struct Fact: Identifiable {
    var id = UUID()
    var image: String
    var content: String
}
