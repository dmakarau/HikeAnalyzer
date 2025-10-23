//
//  TypingIndicatorView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 20.10.25.
//

import SwiftUI

struct TypingIndicatorView: View {
    @State private var isAnimating = false
    private let dotCount = 3
    private let dotSize: CGFloat = 6
    private let bounceHeight: CGFloat = 4
    private let animationDuration: Double = 0.6
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .fill(Color.gray)
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(isAnimating ? 1.2 : 0.8)
                    .offset(y: isAnimating ? -bounceHeight : 0)
                    .opacity(isAnimating ? 1 : 0.5)
                    .animation(
                        .easeInOut(duration: animationDuration)
                            .repeatForever()
                            .delay(Double(index) * animationDuration / Double(dotCount)),
                        value: isAnimating
                    )
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .onAppear { 
            withAnimation {
                isAnimating = true 
            }
        }
        .onDisappear {
            isAnimating = false
        }
    }
}

#Preview {
    VStack {
        TypingIndicatorView()
        
        // Preview in context
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.title2)
                .foregroundColor(.blue)
            
            TypingIndicatorView()
            
            Spacer()
        }
        .padding()
    }
    .background(Color(.systemGray5))
}
