//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Taewon Yoon on 2023/09/06.
//

import SwiftUI

struct CreditsView: View {
    // MARK: - PROPERTY
    @State private var randomNumber: Int = Int.random(in: 1...4)
    
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    // MARK: - BODY
    
    
    var body: some View {
        VStack(spacing: 3) {
            // PROFILE IMAGE
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            // HEADER
            HeaderView(title: "Credits")
            // CONTENT
            Text("Taewon Yoon")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        } //: VSTACK
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
