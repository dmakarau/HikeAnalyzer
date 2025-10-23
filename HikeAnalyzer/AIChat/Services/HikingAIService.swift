//
//  HikingAIService.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation
import FoundationModels

/// Service responsible for generating AI responses for hiking-related queries
struct HikingAIService {
    
    private static let model = SystemLanguageModel.default
    
    private static let session = LanguageModelSession {
        """
        You are an expert hiking assistant. Provide helpful, accurate, and context-aware responses to user questions about hiking, trail safety, gear recommendations, weather considerations, and risk assessment. Tailor your answers to the user's experience level and the specific hiking context they provide.
        """
    }
    
    /// Generates contextual AI responses based on user input
    /// - Parameter userMessage: The user's message/question
    /// - Returns: An appropriate AI response focused on hiking assistance
    static func generateResponse(for userMessage: String) async throws -> String {
        let respond = try await session.respond(to: userMessage)
        return respond.content
    }
    
    /// Provides a welcome message for new chat sessions
    static var welcomeMessage: String {
        "Hi! I'm your AI hiking assistant. I can help you with trail planning, safety tips, gear recommendations, and answer any hiking-related questions you might have. How can I assist you today?"
    }
}
