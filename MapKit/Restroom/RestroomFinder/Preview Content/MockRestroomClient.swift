//
//  MockRestroomClient.swift
//  RestroomFinder
//
//  Created by Taewon Yoon on 10/23/23.
//

import Foundation

struct MockRestroomClient: HTTPClient {
    // HTTPClient 프로토콜을 준수하는 mock restroom client를 만들었다
    func fetchRestrooms(url: URL) async throws -> [Restroom] {
        return PreviewData.load(resourceName: "restrooms")
    }
}
