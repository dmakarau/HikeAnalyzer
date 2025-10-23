//
//  HikingAIService.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

/// Service responsible for generating AI responses for hiking-related queries
struct HikingAIService {
    
    /// Checks if FoundationModels is available on this device
    static var isFoundationModelsAvailable: Bool {
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *) {
            return true
        }
        #endif
        return false
    }
    
    /// Generates an AI response for the given user message
    static func generateResponse(for message: String) async -> String {
        if isFoundationModelsAvailable {
            #if canImport(FoundationModels)
            do {
                let model = SystemLanguageModel.default
                let session = LanguageModelSession {
                    ChatConstants.SystemPrompts.hikingAssistant
                }
                
                let response = try await session.respond(to: message)
                return response.content
            } catch {
                return ChatConstants.Errors.connectionFailed
            }
            #endif
        }
        
        return ChatConstants.Errors.notSupported
    }
    
    /// Provides a welcome message for new chat sessions
    static var welcomeMessage: String {
        if isFoundationModelsAvailable {
            return ChatConstants.Welcome.aiEnabled
        } else {
            return ChatConstants.Welcome.aiNotSupported
        }
    }
}
