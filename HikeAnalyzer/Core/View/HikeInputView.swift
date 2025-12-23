//
//  HikeInputView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 08.07.25.
//

import SwiftUI

struct HikeInputView<Content: View>: View {
    let iconName: String
    let label: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.xs) {
            // Label Section
            HStack(spacing: .spacing.sm) {
                IconContainer(iconName: iconName)
                
                Text(label)
                    .font(.theme.subheadline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Spacer()
            }
            
            // Content Section
            HStack {
                Spacer()
                content
                    .font(.theme.callout)
            }
        }
        .cardStyle()
    }
}

struct IconContainer: View {
    let iconName: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.theme.primary.opacity(0.1),
                            Color.theme.primary.opacity(0.2)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 36, height: 36)
            
            Image(systemName: iconName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.theme.primary)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        HikeInputView(iconName: "figure.hiking", label: "Distance") {
            Text("5.2 km")
                .foregroundColor(Color.theme.textSecondary)
        }
        
        HikeInputView(iconName: "mountain.2.fill", label: "Elevation") {
            Text("1,200 m")
                .foregroundColor(Color.theme.textSecondary)
        }
    }
    .padding()
    .trailTheme()
}
