//
//  ChatViewModel.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation
import Combine

@Observable
@MainActor
final class ChatViewModel {
    // MARK: - Properties
    var messages: [ChatMessage] = []
    var messageText = ""
    var isGeneratingResponse = false
    var hasError = false
    var errorMessage = ""
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init() {
        setupInitialMessage()
    }
    
    // MARK: - Public Methods
    func sendMessage() async {
        let userMessage = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userMessage.isEmpty, !isGeneratingResponse else { return }
        
        // Add user message
        addUserMessage(userMessage)
        clearMessageText()
        
        // Generate AI response
        await generateAIResponse(for: userMessage)
    }
    
    func clearError() {
        hasError = false
        errorMessage = ""
    }
    
    var canSendMessage: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isGeneratingResponse
    }
    
    var shouldShowTypingIndicator: Bool {
        isGeneratingResponse
    }
    
    // MARK: - Private Methods
    private func setupInitialMessage() {
        let welcomeMessage = ChatMessage(
            content: HikingAIService.welcomeMessage,
            isFromUser: false
        )
        messages = [welcomeMessage]
    }
    
    private func addUserMessage(_ content: String) {
        let userMessage = ChatMessage(
            id: UUID(),
            content: content,
            isFromUser: true,
            timestamp: Date()
        )
        messages.append(userMessage)
    }
    
    private func addAIMessage(_ content: String) {
        let aiMessage = ChatMessage(
            id: UUID(),
            content: content,
            isFromUser: false,
            timestamp: Date()
        )
        messages.append(aiMessage)
    }
    
    private func clearMessageText() {
        messageText = ""
    }
    
    private func generateAIResponse(for userMessage: String) async {
        isGeneratingResponse = true
        clearError()
        
        let aiResponse = await HikingAIService.generateResponse(for: userMessage)
        addAIMessage(aiResponse)
        
        isGeneratingResponse = false
    }
    
    private func handleAIError(_ error: Error) {
        hasError = true
        errorMessage = "I'm having trouble connecting right now. Please try again."
        
        // Add fallback message to chat
        addAIMessage("I'm sorry, I'm having trouble connecting right now. Please try again in a moment.")
    }
}

// MARK: - Service Protocol
protocol HikingAIServiceProtocol {
    static func generateResponse(for message: String) async throws -> String
}

// MARK: - Service Conformance
extension HikingAIService: HikingAIServiceProtocol {}