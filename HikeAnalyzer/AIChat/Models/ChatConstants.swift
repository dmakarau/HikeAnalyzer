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
    
    // MARK: - Analysis Messages
    struct Analysis {
        static let reportReady = "Here's your personalized trail analysis."
    }

    // MARK: - AI System Prompt
    struct SystemPrompts {
        static let hikingAssistant = """
        You are an expert hiking assistant with access to an on-device CoreML trail risk analyzer.
        For general hiking questions, respond concisely and helpfully.
        When a user describes a specific trail — providing distance, elevation, terrain, or wildlife conditions — \
        call the analyzeTrail tool to get the risk prediction, then use that result to inform your full response.
        Always base risk assessments on the CoreML tool output, not on assumptions.
        """
    }
}
