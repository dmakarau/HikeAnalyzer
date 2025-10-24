//
//  RiskSummaryView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 18.07.25.
//

import SwiftUI

struct RiskSummaryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: .spacing.lg) {
                    // Header
                    SummaryHeaderView()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -20)
                        .animation(.easeOut(duration: 0.6).delay(0.1), value: isAnimating)
                    
                    // Risk Level Cards
                    LazyVStack(spacing: .spacing.md) {
                        ForEach(Array(Risk.allCases.enumerated()), id: \.element.id) { index, risk in
                            CompactRiskCardView(risk: risk)
                                .opacity(isAnimating ? 1 : 0)
                                .offset(x: isAnimating ? 0 : -50)
                                .animation(
                                    .easeOut(duration: 0.6)
                                    .delay(0.2 + Double(index) * 0.1),
                                    value: isAnimating
                                )
                        }
                    }
                }
                .padding(.vertical, .spacing.lg)
            }
            .navigationTitle("Risk Levels Guide")
            .navigationBarTitleDisplayMode(.large)
            .trailTheme()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.primary)
                }
            }
            .onAppear {
                isAnimating = true
            }
        }
    }
}

struct SummaryHeaderView: View {
    var body: some View {
        VStack(spacing: .spacing.md) {
            Image(systemName: "chart.bar.doc.horizontal")
                .font(.system(size: 50))
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.theme.primary,
                            Color.theme.primaryDark
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            VStack(spacing: .spacing.xs) {
                Text("Risk Assessment Guide")
                    .font(.theme.title2)
                    .foregroundColor(Color.theme.textPrimary)
                
                Text("Understanding different trail difficulty levels")
                    .font(.theme.callout)
                    .foregroundColor(Color.theme.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, .spacing.lg)
    }
}

struct CompactRiskCardView: View {
    let risk: Risk
    
    var body: some View {
        HStack(spacing: .spacing.md) {
            // Risk Icon
            ZStack {
                Circle()
                    .fill(risk.color.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(risk.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(risk.color)
            }
            
            // Risk Info
            VStack(alignment: .leading, spacing: .spacing.xs) {
                HStack {
                    Text(risk.displayName)
                        .font(.theme.headline)
                        .foregroundColor(Color.theme.textPrimary)
                    
                    Spacer()
                    
                    RiskLevelIndicator(risk: risk)
                }
                
                Text(risk.shortDescription)
                    .font(.theme.callout)
                    .foregroundColor(Color.theme.textSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .cardStyle()
    }
}

// Extension for short descriptions
extension Risk {
    var shortDescription: String {
        switch self {
        case .easy:
            return "Perfect for beginners and casual outdoor enthusiasts"
        case .moderate:
            return "Suitable for hikers with some experience and fitness"
        case .difficult:
            return "Challenging trail requiring good fitness and experience"
        case .highRisk:
            return "Expert level with significant challenges and dangers"
        }
    }
}

#Preview {
    RiskSummaryView()
}

#Preview {
    RiskSummaryView()
}
