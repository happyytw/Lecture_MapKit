//
//  HTTPClient.swift
//  RestroomFinder
//
//  Created by Taewon Yoon on 10/23/23.
//

import Foundation
// Stub은 테스트 중에 만들어진 호출에 미리 준비된 답변을 제공하며 일반적으로 테스트를 위해 프로그래밍된 것 외에는 전혀 응답하지 않습니다
// 아래 Stub는 단순히 UI에 실제 데이터, 일종의 더미 데이터를 제공할 것이라는 것을 의미합니다.
protocol HTTPClient {
    
    func fetchRestrooms(url: URL) async throws -> [Restroom]
}
