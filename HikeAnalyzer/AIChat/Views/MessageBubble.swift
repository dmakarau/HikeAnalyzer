//
//  MessageBubble.swift
//  AISocialChat
//
//  Created by Denis Makarau on 20.10.25.
//

import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        Text(message.content)
            .font(.theme.body)
            .padding(.spacing.sm)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(backgroundStyle)
            )
            .foregroundStyle(message.isFromUser ? .white : Color.theme.textPrimary)
            .frame(maxWidth: 300, alignment: message.isFromUser ? .trailing : .leading)
            .animation(.smooth, value: message.content)
    }
    
    private var backgroundStyle: AnyShapeStyle {
        if message.isFromUser {
            AnyShapeStyle(LinearGradient(
                gradient: Gradient(colors: [
                    Color.theme.primary,
                    Color.theme.primaryDark
                ]),
                startPoint: .leading,
                endPoint: .trailing
            ))
        } else {
            AnyShapeStyle(Color.theme.cardBackground)
        }
    }
}

#Preview {
    VStack {
        MessageBubble(message: ChatMessage(
            content: "Hello, this is a test message from the user", 
            isFromUser: true
        ))
        MessageBubble(message: ChatMessage(
            content: "Hi! I'm here to help you with hiking advice.", 
            isFromUser: false
        ))
    }
    .padding()
}
