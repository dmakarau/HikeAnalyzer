//
//  MessageRow.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import SwiftUI

struct MessageRow: View {
    let message: ChatMessage
    
    var body: some View {
        VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: .spacing.xs) {
            HStack {
                if message.isFromUser {
                    Spacer(minLength: 50)
                    MessageBubble(message: message)
                } else {
                    HStack(alignment: .top, spacing: .spacing.sm) {
                        UserAvatar()
                        MessageBubble(message: message)
                    }
                    Spacer(minLength: 50)
                }
            }
            
            MessageTimestamp(
                timestamp: message.timestamp,
                isFromUser: message.isFromUser
            )
        }
        .id(message.id)
    }
}

// MARK: - Supporting Views
private struct UserAvatar: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .font(.title2)
            .foregroundColor(Color.theme.secondary)
    }
}

private struct MessageTimestamp: View {
    let timestamp: Date
    let isFromUser: Bool
    
    var body: some View {
        Text(timestamp, format: .dateTime.hour().minute())
            .font(.theme.caption)
            .foregroundColor(Color.theme.textTertiary)
            .padding(.horizontal, isFromUser ? .spacing.md : 36)
    }
}

#Preview {
    VStack(spacing: .spacing.md) {
        MessageRow(message: ChatMessage(
            content: "Hello! I'm your AI hiking assistant. How can I help you today?",
            isFromUser: false
        ))
        
        MessageRow(message: ChatMessage(
            content: "What should I pack for a day hike?",
            isFromUser: true
        ))
    }
    .padding()
}