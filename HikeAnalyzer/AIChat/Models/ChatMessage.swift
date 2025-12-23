//
//  ChatMessage.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 18.09.25.
//

import Foundation

/// Represents a single message in the AI chat conversation
struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let content: String
    let isFromUser: Bool
    let timestamp: Date
    
    init(id: UUID = UUID(), content: String, isFromUser: Bool, timestamp: Date = Date()) {
        self.id = id
        self.content = content
        self.isFromUser = isFromUser
        self.timestamp = timestamp
    }
}