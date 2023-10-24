//
//  RestroomDetailView.swift
//  RestroomFinder
//
//  Created by Taewon Yoon on 10/23/23.
//

import SwiftUI

struct RestroomDetailView: View {
    
    let restroom: Restroom
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(restroom.name)
                .font(.title3)
            Text(restroom.address)
            if let comment = restroom.comment {
                Text(comment)
                    .font(.caption)
            }
            
            AmenitiesView(restroom: restroom)
            
            ActionButtons(mapItem: restroom.mapItem)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    let restrooms: [Restroom] = PreviewData.load(resourceName: "restrooms")
    return RestroomDetailView(restroom: restrooms[6])
}
