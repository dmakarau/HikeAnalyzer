//
//  ContentView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputViewModel = TrailInputViewModel()
    @State private var showAISupport = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: .spacing.md) {
                    // Header Section
                    HeaderView()
                        .opacity(inputViewModel.isAnimating ? 1 : 0)
                        .offset(y: inputViewModel.isAnimating ? 0 : -20)
                        .animation(.easeOut(duration: 0.8).delay(0.1), value: inputViewModel.isAnimating)
                    
                    // Input Form
                    VStack(spacing: .spacing.sm) {
                        HikeInfoView(trailInfo: $inputViewModel.trailInfo)
                        
                        // Validation Feedback
                        if inputViewModel.hasValidationErrors {
                            ValidationErrorView(errors: inputViewModel.validationErrors)
                                .transition(.opacity.combined(with: .slide))
                        }
                    }
                    .opacity(inputViewModel.isAnimating ? 1 : 0)
                    .offset(y: inputViewModel.isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.3), value: inputViewModel.isAnimating)
                    
                    // Submit Button - Enhanced with AI Analysis
                    NavigationLink {
                        EnhancedPredictionResultView(
                            trailInfo: inputViewModel.trailInfo,
                            userProfile: inputViewModel.userProfile
                        )
                    } label: {
                        HStack(spacing: .spacing.sm) {
                            Image(systemName: "brain.head.profile")
                                .font(.headline)
                            Text("AI Trail Analysis")
                        }
                        .primaryButtonStyle()
                    }
                    .disabled(!inputViewModel.isValidForAnalysis)
                    .opacity(inputViewModel.isAnimating ? 1 : 0)
                    .offset(y: inputViewModel.isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.5), value: inputViewModel.isAnimating)
                    
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
                    .opacity(inputViewModel.isAnimating ? 1 : 0)
                    .offset(y: inputViewModel.isAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.7), value: inputViewModel.isAnimating)
                }
                .padding(.vertical, .spacing.md)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
            .navigationTitle("Trail Analyzer")
            .navigationBarTitleDisplayMode(.large)
            .trailTheme()
            .onAppear {
                inputViewModel.setAnimationState(true)
            }
            .onChange(of: inputViewModel.trailInfo) { _, _ in
                // Real-time validation
                inputViewModel.validateInput()
            }
            .sheet(isPresented: $showAISupport) {
                AISupportChatView()
            }
        }
        .tint(Color.theme.primary)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Validation Error View

struct ValidationErrorView: View {
    let errors: [ValidationError]
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.xs) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                Text("Please fix the following issues:")
                    .font(.theme.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.orange)
                Spacer()
            }
            
            ForEach(errors, id: \.localizedDescription) { error in
                HStack(alignment: .top, spacing: .spacing.xs) {
                    Text("•")
                        .foregroundColor(.orange)
                    Text(error.localizedDescription)
                        .font(.theme.caption)
                        .foregroundColor(Color.theme.textSecondary)
                    Spacer()
                }
            }
        }
        .padding(.spacing.sm)
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
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
