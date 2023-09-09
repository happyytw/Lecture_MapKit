//
//  CardModel.swift
//  Learn by Doing
//
//  Created by Taewon Yoon on 2023/09/09.
//

import SwiftUI

// MARK: - CARD MODEL

struct Card: Identifiable {
    var id = UUID() // 카드에 고유 id를 부여함으로써 카드를 구분하는데 사용한다
    var title: String
    var headline: String
    var imageName: String
    var callToAction: String
    var message: String
    var gradientColors: [Color]
}
