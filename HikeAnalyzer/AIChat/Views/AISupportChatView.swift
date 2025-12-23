//
//  AISupportChatView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 28.09.25.
//

import SwiftUI

struct AISupportChatView: View {
    @State private var chatViewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MessageListView(
                    messages: chatViewModel.messages,
                    isGeneratingResponse: chatViewModel.isGeneratingResponse
                )
                
                MessageInputView(
                    messageText: $chatViewModel.messageText,
                    isGeneratingResponse: chatViewModel.isGeneratingResponse,
                    canSendMessage: chatViewModel.canSendMessage,
                    onSend: {
                        Task {
                            await chatViewModel.sendMessage()
                        }
                    }
                )
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
            .alert("Connection Error", isPresented: $chatViewModel.hasError) {
                Button("OK") {
                    chatViewModel.clearError()
                }
            } message: {
                Text(chatViewModel.errorMessage)
            }
        }
    }
}

#Preview {
    AISupportChatView()
}