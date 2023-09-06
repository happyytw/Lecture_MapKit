//
//  Note.swift
//  Notes Watch App
//
//  Created by Taewon Yoon on 2023/09/06.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
