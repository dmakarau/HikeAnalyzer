//
//  AISupportChatView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import SwiftUI

struct AISupportChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @State private var isGeneratingResponse = false
    @State private var messages: [ChatMessage] = [
        ChatMessage(
            content: HikingAIService.welcomeMessage,
            isFromUser: false
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Messages List
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: .spacing.sm) {
                            ForEach(messages) { message in
                                VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: .spacing.xs) {
                                    HStack {
                                        if message.isFromUser {
                                            Spacer(minLength: 50)
                                            MessageBubble(message: message)
                                        } else {
                                            HStack(alignment: .top, spacing: .spacing.sm) {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(Color.theme.secondary)
                                                
                                                MessageBubble(message: message)
                                            }
                                            Spacer(minLength: 50)
                                        }
                                    }
                                    
                                    Text(message.timestamp, format: .dateTime.hour().minute())
                                        .font(.theme.caption)
                                        .foregroundColor(Color.theme.textTertiary)
                                        .padding(.horizontal, message.isFromUser ? .spacing.md : 36)
                                }
                                .id(message.id)
                            }
                            
                            // Typing indicator when AI is generating response
                            if isGeneratingResponse {
                                HStack {
                                    VStack(alignment: .leading, spacing: .spacing.xs) {
                                        HStack(alignment: .top, spacing: .spacing.sm) {
                                            Image(systemName: "person.crop.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(Color.theme.secondary)
                                            
                                            TypingIndicatorView()
                                        }
                                        
                                        Text("AI is typing...")
                                            .font(.theme.caption)
                                            .foregroundColor(Color.theme.textTertiary)
                                            .padding(.leading, 36)
                                    }
                                    
                                    Spacer(minLength: 50)
                                }
                                .id("typing-indicator")
                            }
                        }
                        .padding(.horizontal, .spacing.md)
                        .padding(.vertical, .spacing.sm)
                    }
                    .onChange(of: messages.count) { _, _ in
                        if isGeneratingResponse {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo("typing-indicator", anchor: .bottom)
                            }
                        } else if let lastMessage = messages.last {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                    .onChange(of: isGeneratingResponse) { _, _ in
                        if isGeneratingResponse {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo("typing-indicator", anchor: .bottom)
                            }
                        } else if let lastMessage = messages.last {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input Section
                VStack(spacing: .spacing.sm) {
                    Divider()
                    
                    HStack(spacing: .spacing.sm) {
                        TextField("Ask about hiking, trails, safety...", text: $messageText, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(1...4)
                            .onSubmit {
                                if !isGeneratingResponse {
                                    Task {
                                        await sendMessage()
                                    }
                                }
                            }
                        
                        Button {
                            Task {
                                await sendMessage()
                            }
                        } label: {
                            if isGeneratingResponse {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .foregroundColor(Color.theme.primary)
                            } else {
                                Image(systemName: "paperplane.fill")
                                    .font(.title2)
                                    .foregroundColor(messageText.isEmpty ? Color.theme.textTertiary : Color.theme.primary)
                            }
                        }
                        .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isGeneratingResponse)
                    }
                    .padding(.horizontal, .spacing.md)
                    .padding(.bottom, .spacing.sm)
                }
                .background(Color.theme.backgroundPrimary)
            }
            .navigationTitle("AI Hiking Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(Color.theme.primary)
                }
            }
            .background(Color.theme.backgroundSecondary)
        }
    }
    
    private func sendMessage() async {
        let userMessage = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userMessage.isEmpty else { return }
        
        // Add user message
        let newMessage = ChatMessage(
            id: UUID(),
            content: userMessage,
            isFromUser: true,
            timestamp: Date()
        )
        messages.append(newMessage)
        messageText = ""
        
        // Generate AI response
        isGeneratingResponse = true
        
        do {
            let aiResponse = try await HikingAIService.generateResponse(for: userMessage)
            let aiMessage = ChatMessage(
                id: UUID(),
                content: aiResponse,
                isFromUser: false,
                timestamp: Date()
            )
            messages.append(aiMessage)
        } catch {
            // Handle error with a fallback message
            let errorMessage = ChatMessage(
                id: UUID(),
                content: "I'm sorry, I'm having trouble connecting right now. Please try again in a moment.",
                isFromUser: false,
                timestamp: Date()
            )
            messages.append(errorMessage)
        }
        
        isGeneratingResponse = false
    }
}

#Preview {
    AISupportChatView()
}