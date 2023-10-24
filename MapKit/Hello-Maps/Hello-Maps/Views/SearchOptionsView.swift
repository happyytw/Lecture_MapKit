//
//  SearchOptionsView.swift
//  Hello-Maps
//
//  Created by Taewon Yoon on 10/21/23.
//

import SwiftUI

struct SearchOptionsView: View {
    
    let searchOptions = ["식당":"fork.knife", "hotels":"bad.double.fill", "Coffee":"cup.and.saucer.fill"]
    
    let onSelected: (String) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(searchOptions.sorted(by: >), id: \.0) { key, value in
                    Button(action: {
                        // action
                        onSelected(key)
                    }, label: {
                        HStack {
                            Image(systemName: value)
                            Text(key)
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
                    .foregroundStyle(.black)
                    .padding(4)
                }
            }
        }
    }
}

#Preview {
    SearchOptionsView(onSelected: { _ in })
}
