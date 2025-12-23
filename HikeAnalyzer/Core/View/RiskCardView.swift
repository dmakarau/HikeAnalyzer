//
//  RiskCardView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 15.07.25.
//

import SwiftUI

struct RiskCardView: View {
    let riskLevel: Risk
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: .spacing.lg) {
            // Risk Icon and Level
            VStack(spacing: .spacing.md) {
                ZStack {
                    Circle()
                        .fill(riskLevel.color.opacity(0.1))
                        .frame(width: 100, height: 100)
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                    
                    Circle()
                        .fill(riskLevel.color.opacity(0.2))
                        .frame(width: 80, height: 80)
                        .scaleEffect(isAnimating ? 1.0 : 0.9)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true).delay(0.5), value: isAnimating)
                    
                    Image(riskLevel.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(riskLevel.color)
                }
                
                VStack(spacing: .spacing.xs) {
                    Text(riskLevel.displayName)
                        .font(.theme.title)
                        .fontWeight(.bold)
                        .foregroundColor(riskLevel.color)
                    
                    RiskLevelIndicator(risk: riskLevel)
                }
            }
            
            // Risk Description
            VStack(alignment: .leading, spacing: .spacing.sm) {
                Text("Risk Assessment")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Text(riskLevel.description)
                    .font(.theme.body)
                    .foregroundColor(Color.theme.textSecondary)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Risk Level Bar
            RiskProgressBar(risk: riskLevel)
        }
        .cardStyle()
        .onAppear {
            isAnimating = true
        }
    }
}

struct RiskLevelIndicator: View {
    let risk: Risk
    
    var body: some View {
        HStack(spacing: .spacing.xs) {
            ForEach(1...4, id: \.self) { level in
                Circle()
                    .fill(level <= risk.level ? risk.color : Color.theme.separatorColor)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

struct RiskProgressBar: View {
    let risk: Risk
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.xs) {
            HStack {
                Text("Risk Level")
                    .font(.theme.caption)
                    .foregroundColor(Color.theme.textSecondary)
                
                Spacer()
                
                Text("\(Int(CGFloat(risk.level) / 4 * 100))%")
                    .font(.theme.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(risk.color)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.theme.separatorColor)
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    risk.color.opacity(0.8),
                                    risk.color
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                progress = CGFloat(risk.level) / 4
            }
        }
    }
}

// Extension to add color and level properties to Risk
extension Risk {
    var color: Color {
        switch self {
        case .highRisk:
            return Color.theme.riskHigh
        case .difficult:
            return Color.theme.riskDifficult
        case .moderate:
            return Color.theme.riskModerate
        case .easy:
            return Color.theme.riskEasy
        }
    }
    
    var level: Int {
        switch self {
        case .easy: return 1
        case .moderate: return 2
        case .difficult: return 3
        case .highRisk: return 4
        }
    }
    
    var displayName: String {
        switch self {
        case .highRisk: return "High Risk"
        case .difficult: return "Difficult"
        case .moderate: return "Moderate"
        case .easy: return "Easy"
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            RiskCardView(riskLevel: .easy)
            RiskCardView(riskLevel: .moderate)
            RiskCardView(riskLevel: .difficult)
            RiskCardView(riskLevel: .highRisk)
        }
        .padding()
    }
    .trailTheme()
}

#Preview {
    RiskCardView(riskLevel: .easy)
}
