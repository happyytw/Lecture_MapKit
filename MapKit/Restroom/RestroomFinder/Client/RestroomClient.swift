//
//  RestrommClient.swift
//  RestroomFinder
//
//  Created by Taewon Yoon on 10/23/23.
//

import Foundation
import SwiftUI

struct AmenitiesView: View {
    
    let restroom: Restroom
    
    var body: some View {
        HStack(spacing: 12) {
            AmenityView(symbol: "♿️", isEnabled: restroom.accessible)
            AmenityView(symbol: "🚻", isEnabled: restroom.unisex)
            AmenityView(symbol: "🚼", isEnabled: restroom.changingTable)
        }
    }
}

struct AmenityView: View {
    
    let symbol: String
    let isEnabled: Bool
    
    var body: some View {
        if isEnabled {
            Text(symbol)
        }
    }
}

struct RestroomClient: HTTPClient {
    
    private enum RestroomClientError: Error {
        case invalidResponse
        case networkError(Error)
    }
    
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {// 화장실을 만드는 것이 아니기 때문에 항상 성공(200)
            throw RestroomClientError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([Restroom].self, from: data)
        } catch {
            throw RestroomClientError.networkError(error)
        }
    }
    
}
