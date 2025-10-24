//
//  MessageInputView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 02.10.25.
//

import SwiftUI

struct MessageInputView: View {
    @Binding var messageText: String
    let isGeneratingResponse: Bool
    let canSendMessage: Bool
    let onSend: () -> Void
    
    var body: some View {
        VStack(spacing: .spacing.sm) {
            Divider()
            
            HStack(spacing: .spacing.sm) {
                MessageTextField(
                    text: $messageText,
                    isGeneratingResponse: isGeneratingResponse,
                    onSubmit: onSend
                )
                
                SendButton(
                    isGeneratingResponse: isGeneratingResponse,
                    canSend: canSendMessage,
                    onSend: onSend
                )
            }
            .padding(.horizontal, .spacing.md)
            .padding(.bottom, .spacing.sm)
        }
        .background(Color.theme.backgroundPrimary)
    }
}

// MARK: - Supporting Views
private struct MessageTextField: View {
    @Binding var text: String
    let isGeneratingResponse: Bool
    let onSubmit: () -> Void
    
    var body: some View {
        TextField("Ask about hiking, trails, safety...", text: $text, axis: .vertical)
            .textFieldStyle(.roundedBorder)
            .lineLimit(1...4)
            .onSubmit {
                if !isGeneratingResponse {
                    onSubmit()
                }
            }
    }
}

private struct SendButton: View {
    let isGeneratingResponse: Bool
    let canSend: Bool
    let onSend: () -> Void
    
    var body: some View {
        Button(action: onSend) {
            Group {
                if isGeneratingResponse {
                    ProgressView()
                        .scaleEffect(0.8)
                        .foregroundColor(Color.theme.primary)
                } else {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(buttonColor)
                }
            }
        }
        .disabled(!canSend)
    }
    
    private var buttonColor: Color {
        canSend ? Color.theme.primary : Color.theme.textTertiary
    }
}

#Preview {
    VStack {
        Spacer()
        MessageInputView(
            messageText: .constant("Sample message text"),
            isGeneratingResponse: false,
            canSendMessage: true,
            onSend: {}
        )
    }
}