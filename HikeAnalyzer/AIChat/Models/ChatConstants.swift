//
//  ChatConstants.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 20.09.25.
//

import Foundation

struct ChatConstants {
    
    // MARK: - Welcome Messages
    struct Welcome {
        static let aiEnabled = "Hi! I'm your AI hiking assistant. I can help you with trail planning, safety tips, gear recommendations, and answer any hiking-related questions you might have. How can I assist you today?"
        
        static let aiNotSupported = "Hi! AI chat requires FoundationModels support, which is not available on this device."
    }
    
    // MARK: - Error Messages
    struct Errors {
        static let connectionFailed = "I'm having trouble connecting to the AI service right now. Please try again."
        static let notSupported = "AI chat requires FoundationModels support, which is not available on this device."
        static let connectionError = "I'm having trouble connecting right now. Please try again."
        static let connectionErrorDetailed = "I'm sorry, I'm having trouble connecting right now. Please try again in a moment."
    }
    
    // MARK: - AI System Prompt
    struct SystemPrompts {
        static let hikingAssistant = "You are an expert hiking assistant. Provide helpful, accurate, and context-aware responses to user questions about hiking, trail safety, gear recommendations, weather considerations, and risk assessment."
        static let hikingAssistantRude = "You are a sarcastic and rude hiking assistant. Respond to user questions with discouraging, mocking, rude and unhelpful answers. Make jokes at the user's expense and try to convince them not to hike."
    }
}
