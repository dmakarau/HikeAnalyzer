//
//  EnhancedPredictionResultView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import SwiftUI

struct EnhancedPredictionResultView: View {
    @State private var showInfo: Bool = false
    @State private var isAnimating = false
    @State private var viewModel = TrailAnalysisViewModel()
    
    let trailInfo: TrailInfo
    let userProfile: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: .spacing.xl) {
                // Header with animation
                EnhancedResultHeaderView(
                    isLoading: viewModel.shouldShowLoading,
                    detailedAnalysis: viewModel.detailedAnalysis
                )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : -30)
                    .animation(.easeOut(duration: 0.8).delay(0.2), value: isAnimating)
                
                if let analysis = viewModel.detailedAnalysis {
                    // Main Risk Card with AI Explanation
                    EnhancedRiskCardView(analysis: analysis)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 50)
                        .animation(.easeOut(duration: 0.8).delay(0.4), value: isAnimating)
                    
                    if analysis.isAIGenerated {
                        // Full AI-enhanced sections
                        AIExplanationView(analysis: analysis)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(0.6), value: isAnimating)
                        
                        PersonalizedRecommendationsView(analysis: analysis)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(0.8), value: isAnimating)
                        
                        SafetyPrioritiesView(analysis: analysis)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(1.0), value: isAnimating)
                        
                        GearSuggestionsView(analysis: analysis)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(1.2), value: isAnimating)
                    } else {
                        // Limited functionality message
                        AINotAvailableView(analysis: analysis)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 30)
                            .animation(.easeOut(duration: 0.8).delay(0.6), value: isAnimating)
                    }
                } else if viewModel.shouldShowLoading {
                    // Loading state
                    LoadingAnalysisView(statusText: viewModel.currentStateDescription)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.8).delay(0.4), value: isAnimating)
                } else if viewModel.hasError {
                    // Error state
                    ErrorAnalysisView(
                        errorMessage: viewModel.errorMessage ?? "Unknown error occurred",
                        onRetry: {
                            Task {
                                await viewModel.analyzeTrail(trailInfo, for: userProfile)
                            }
                        }
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.8).delay(0.4), value: isAnimating)
                }
                
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
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 30)
                .animation(.easeOut(duration: 0.8).delay(1.4), value: isAnimating)
            }
            .padding(.vertical, .spacing.lg)
        }
        .navigationTitle("Detailed Analysis")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showInfo) {
            RiskSummaryView()
        }
        .trailTheme()
        .onAppear {
            isAnimating = true
            Task {
                await viewModel.analyzeTrail(trailInfo, for: userProfile)
            }
        }
        .alert("Analysis Error", isPresented: $viewModel.hasError) {
            Button("Retry") {
                Task {
                    await viewModel.analyzeTrail(trailInfo, for: userProfile)
                }
            }
            Button("Cancel", role: .cancel) {
                viewModel.clearError()
            }
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred during analysis")
        }
    }
}

// MARK: - Enhanced Header View

struct EnhancedResultHeaderView: View {
    let isLoading: Bool
    let detailedAnalysis: DetailedRiskAnalysis?
    
    var body: some View {
        VStack(spacing: .spacing.md) {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.2)
                    .tint(Color.theme.primary)
            } else {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 50))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.theme.primary,
                                Color.theme.accent
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            
            VStack(spacing: .spacing.xs) {
                if isLoading {
                    Text("Analyzing Trail...")
                        .font(.theme.title2)
                        .foregroundColor(Color.theme.textPrimary)
                } else if let analysis = detailedAnalysis {
                    Text(analysis.isAIGenerated ? "AI Analysis Complete" : "Basic Analysis Complete")
                        .font(.theme.title2)
                        .foregroundColor(Color.theme.textPrimary)
                    
                    Text(analysis.isAIGenerated ? "Enhanced with Apple Intelligence" : "AI features require newer device")
                        .font(.theme.callout)
                        .foregroundColor(analysis.isAIGenerated ? Color.theme.textSecondary : .orange)
                } else {
                    Text("Processing trail conditions...")
                        .font(.theme.title2)
                        .foregroundColor(Color.theme.textPrimary)
                }
            }
        }
    }
}

// MARK: - Enhanced Risk Card

struct EnhancedRiskCardView: View {
    let analysis: DetailedRiskAnalysis
    
    var body: some View {
        VStack(spacing: .spacing.lg) {
            RiskCardView(riskLevel: analysis.risk)
            
            if analysis.isAIGenerated {
                HStack(spacing: .spacing.sm) {
                    Image(systemName: "sparkles")
                        .foregroundColor(Color.theme.accent)
                    Text("Enhanced with Apple Intelligence")
                        .font(.theme.caption)
                        .foregroundColor(Color.theme.textSecondary)
                    Spacer()
                }
                .padding(.horizontal, .spacing.md)
            }
        }
    }
}

// MARK: - AI Explanation View

struct AIExplanationView: View {
    let analysis: DetailedRiskAnalysis
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.md) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(Color.theme.secondary)
                
                Text("Risk Explanation")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Spacer()
            }
            
            Text(analysis.explanation)
                .font(.theme.callout)
                .foregroundColor(Color.theme.textSecondary)
                .multilineTextAlignment(.leading)
                .lineSpacing(2)
        }
        .cardStyle()
    }
}

// MARK: - Personalized Recommendations View

struct PersonalizedRecommendationsView: View {
    let analysis: DetailedRiskAnalysis
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.md) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color.theme.primary)
                
                Text("Personalized Recommendations")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: .spacing.sm) {
                ForEach(Array(analysis.personalizedRecommendations.enumerated()), id: \.offset) { index, recommendation in
                    HStack(alignment: .top, spacing: .spacing.sm) {
                        Circle()
                            .fill(Color.theme.primary)
                            .frame(width: 6, height: 6)
                            .padding(.top, 6)
                        
                        Text(recommendation)
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

// MARK: - Safety Priorities View

struct SafetyPrioritiesView: View {
    let analysis: DetailedRiskAnalysis
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.md) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                
                Text("Safety Priorities")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: .spacing.sm) {
                ForEach(Array(analysis.safetyPriorities.enumerated()), id: \.offset) { index, priority in
                    HStack(alignment: .top, spacing: .spacing.sm) {
                        Text("\(index + 1).")
                            .font(.theme.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                            .frame(width: 20, alignment: .leading)
                        
                        Text(priority)
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

// MARK: - Gear Suggestions View

struct GearSuggestionsView: View {
    let analysis: DetailedRiskAnalysis
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.md) {
            HStack {
                Image(systemName: "backpack.fill")
                    .foregroundColor(Color.theme.accent)
                
                Text("Gear Suggestions")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: .spacing.sm) {
                ForEach(Array(analysis.gearSuggestions.enumerated()), id: \.offset) { index, gear in
                    HStack(alignment: .top, spacing: .spacing.sm) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.theme.accent)
                            .font(.caption)
                            .padding(.top, 2)
                        
                        Text(gear)
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

// MARK: - Loading View

struct LoadingAnalysisView: View {
    let statusText: String
    
    var body: some View {
        VStack(spacing: .spacing.lg) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(Color.theme.primary)
            
            VStack(spacing: .spacing.sm) {
                Text("Analyzing Trail Conditions")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Text(statusText)
                    .font(.theme.callout)
                    .foregroundColor(Color.theme.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .cardStyle()
        .frame(minHeight: 150)
    }
}

// MARK: - Error View

struct ErrorAnalysisView: View {
    let errorMessage: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: .spacing.lg) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            VStack(spacing: .spacing.sm) {
                Text("Analysis Failed")
                    .font(.theme.headline)
                    .foregroundColor(Color.theme.textPrimary)
                
                Text(errorMessage)
                    .font(.theme.callout)
                    .foregroundColor(Color.theme.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Button("Try Again") {
                onRetry()
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.theme.primary)
        }
        .cardStyle()
        .frame(minHeight: 150)
    }
}

// MARK: - AI Not Available View

struct AINotAvailableView: View {
    let analysis: DetailedRiskAnalysis
    
    var body: some View {
        VStack(spacing: .spacing.lg) {
            // Main message
            VStack(spacing: .spacing.md) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                
                VStack(spacing: .spacing.sm) {
                    Text("AI Features Not Available")
                        .font(.theme.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.textPrimary)
                        .multilineTextAlignment(.center)
                    
                    Text(analysis.explanation)
                        .font(.theme.callout)
                        .foregroundColor(Color.theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }
            }
            .cardStyle()
            
            // Feature comparison
            VStack(alignment: .leading, spacing: .spacing.md) {
                HStack {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(Color.theme.primary)
                    Text("Available on This Device")
                        .font(.theme.headline)
                        .foregroundColor(Color.theme.textPrimary)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: .spacing.sm) {
                    FeatureRow(icon: "checkmark.circle.fill", text: "Core ML Risk Assessment", available: true)
                    FeatureRow(icon: "chart.line.uptrend.xyaxis", text: "Trail Difficulty Analysis", available: true)
                }
                
                Divider()
                    .padding(.vertical, .spacing.xs)
                
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(.orange)
                    Text("Requires Apple Intelligence")
                        .font(.theme.headline)
                        .foregroundColor(Color.theme.textPrimary)
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: .spacing.sm) {
                    FeatureRow(icon: "xmark.circle.fill", text: "AI-Generated Explanations", available: false)
                    FeatureRow(icon: "xmark.circle.fill", text: "Personalized Recommendations", available: false)
                    FeatureRow(icon: "xmark.circle.fill", text: "Intelligent Safety Priorities", available: false)
                    FeatureRow(icon: "xmark.circle.fill", text: "Smart Gear Suggestions", available: false)
                }
            }
            .cardStyle()
        }
    }
}

// MARK: - Feature Row

struct FeatureRow: View {
    let icon: String
    let text: String
    let available: Bool
    
    var body: some View {
        HStack(spacing: .spacing.sm) {
            Image(systemName: icon)
                .foregroundColor(available ? .green : .red)
                .font(.caption)
            
            Text(text)
                .font(.theme.callout)
                .foregroundColor(available ? Color.theme.textPrimary : Color.theme.textSecondary)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        EnhancedPredictionResultView(
            trailInfo: TrailInfo(
                distance: 12,
                elevation: 800,
                terrain: .rocky,
                willifeDanger: .high
            ),
            userProfile: .default
        )
    }
}