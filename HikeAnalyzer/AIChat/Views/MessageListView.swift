//
//  MessageListView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 05.10.25.
//

import SwiftUI

struct MessageListView: View {
    let messages: [ChatMessage]
    let isGeneratingResponse: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: .spacing.sm) {
                    ForEach(messages) { message in
                        MessageRow(message: message)
                    }
                    
                    if isGeneratingResponse {
                        TypingIndicatorRow()
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
    }
}

// MARK: - Supporting Views
private struct TypingIndicatorRow: View {
    var body: some View {
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

#Preview {
    MessageListView(
        messages: [
            ChatMessage(
                content: "Hello! How can I help you with hiking today?",
                isFromUser: false
            ),
            ChatMessage(
                content: "What should I pack for a day hike?",
                isFromUser: true
            ),
            ChatMessage(
                content: "Great question! For a day hike, I recommend packing the essentials: water, snacks, first aid kit, map, and appropriate clothing layers.",
                isFromUser: false
            )
        ],
        isGeneratingResponse: true
    )
}