//
//  ContentView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var trailInfo = TrailInfo()
    @State private var isAnimating = false
    @State private var showAISupport = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: .spacing.md) {
                    // Header Section
                    HeaderView()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -20)
                        .animation(.easeOut(duration: 0.8).delay(0.1), value: isAnimating)
                    
                    // Input Form
                    VStack(spacing: .spacing.sm) {
                        HikeInfoView(trailInfo: $trailInfo)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.3), value: isAnimating)
                    
                    // Submit Button
                    NavigationLink {
                        let analyzer = TrailAnalyzer()
                        let risk = analyzer.predictRisk(trailInfo: trailInfo)
                        PredictionResultView(risk: risk)
                    } label: {
                        HStack(spacing: .spacing.sm) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.headline)
                            Text("Analyze Trail")
                        }
                        .primaryButtonStyle()
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.5), value: isAnimating)
                    
                    // AI Support Button
                    Button {
                        showAISupport = true
                    } label: {
                        HStack(spacing: .spacing.sm) {
                            Image(systemName: "questionmark.bubble.fill")
                                .font(.headline)
                            Text("AI Hiking Assistant")
                        }
                        .supportButtonStyle()
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.7), value: isAnimating)
                }
                .padding(.vertical, .spacing.md)
            }
            .navigationTitle("Trail Analyzer")
            .navigationBarTitleDisplayMode(.large)
            .trailTheme()
            .onAppear {
                isAnimating = true
            }
            .sheet(isPresented: $showAISupport) {
                AISupportChatView()
            }
        }
        .tint(Color.theme.primary)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(spacing: .spacing.sm) {
            Image(systemName: "mountain.2.fill")
                .font(.system(size: 40))
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
                Text("Plan Your Adventure")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Text("Enter your hike details for personalized risk analysis")
                    .font(.theme.subheadline)
                    .foregroundColor(Color.theme.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, .spacing.md)
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
