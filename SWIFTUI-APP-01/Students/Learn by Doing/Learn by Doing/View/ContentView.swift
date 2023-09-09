//
//  ContentView.swift
//  Learn by Doing
//
//  Created by Taewon Yoon on 2023/09/09.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    var cards: [Card] = cardData
    
    // MARK: - CONTENT
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(0 ..< 6) { item in
//                    CardView()
                    CardView(card: cardData[item])
                }
            }
        }
        
        
        
        
        
    }
}

// MARK: -  PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
            .previewLayout(.sizeThatFits)
    }
}
