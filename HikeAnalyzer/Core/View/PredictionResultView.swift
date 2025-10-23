//
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import SwiftUI

struct PredictionResultView: View {
    @State private var showInfo: Bool = false
    @State private var isAnimating = false
    let risk: Risk
    
    var body: some View {
        ScrollView {
            VStack(spacing: .spacing.xl) {
                // Header with animation
                ResultHeaderView(risk: risk)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : -30)
                    .animation(.easeOut(duration: 0.8).delay(0.2), value: isAnimating)
                
                // Main Risk Card
                RiskCardView(riskLevel: risk)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 50)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: isAnimating)
                
                // Action Buttons
                VStack(spacing: .spacing.md) {
                    Button {
                        showInfo.toggle()
                    } label: {
                        HStack(spacing: .spacing.sm) {
                            Image(systemName: "info.circle.fill")
                            Text("View All Risk Levels")
                        }
                        .font(.theme.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.theme.cardBackground)
                        .foregroundColor(Color.theme.primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.theme.primary, lineWidth: 2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    // Quick Tips Section
                    QuickTipsView(risk: risk)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 30)
                .animation(.easeOut(duration: 0.8).delay(0.6), value: isAnimating)
            }
            .padding(.vertical, .spacing.lg)
        }
        .navigationTitle("Analysis Result")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showInfo) {
            RiskSummaryView()
        }
        .trailTheme()
        .onAppear {
            isAnimating = true
        }
    }
}

struct ResultHeaderView: View {
    let risk: Risk
    
    var body: some View {
        VStack(spacing: .spacing.md) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(Color.theme.accent)
            
            VStack(spacing: .spacing.xs) {
                Text("Analysis Complete")
                    .font(.theme.title2)
                    .foregroundColor(Color.theme.textPrimary)
                
                Text("Based on your trail parameters")
                    .font(.theme.callout)
                    .foregroundColor(Color.theme.textSecondary)
            }
        }
    }
}

struct QuickTipsView: View {
    let risk: Risk
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.md) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(Color.theme.secondary)
                
                Text("Quick Tips")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: .spacing.sm) {
                ForEach(risk.tips, id: \.self) { tip in
                    HStack(alignment: .top, spacing: .spacing.sm) {
                        Circle()
                            .fill(Color.theme.primary)
                            .frame(width: 6, height: 6)
                            .padding(.top, 6)
                        
                        Text(tip)
                            .font(.theme.callout)
                            .foregroundColor(Color.theme.textSecondary)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                }
            }
        }
        .cardStyle()
    }
}

// Extension to add tips to Risk enum
extension Risk {
    var tips: [String] {
        switch self {
        case .easy:
            return [
                "Perfect for beginners and casual hikers",
                "Bring water and wear comfortable shoes",
                "Enjoy the scenery and take your time"
            ]
        case .moderate:
            return [
                "Suitable for hikers with some experience",
                "Pack extra water and snacks",
                "Check weather conditions before departure",
                "Inform someone about your hiking plans"
            ]
        case .difficult:
            return [
                "Recommended for experienced hikers only",
                "Bring proper hiking equipment and gear",
                "Start early to avoid afternoon weather",
                "Consider hiking with a partner",
                "Emergency whistle and first aid kit advised"
            ]
        case .highRisk:
            return [
                "Expert level hiking skills required",
                "Professional guide recommended",
                "Complete emergency preparedness essential",
                "Weather monitoring critical",
                "Satellite communication device advised",
                "Inform park rangers of your plans"
            ]
        }
    }
}

#Preview {
    NavigationStack {
        PredictionResultView(risk: .difficult)
    }
}

#Preview {
    NavigationStack {
        PredictionResultView(risk: .difficult)
    }
}
