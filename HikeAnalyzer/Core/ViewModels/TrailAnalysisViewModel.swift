//
//  TrailAnalysisViewModel.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation

/// ViewModel responsible for managing trail analysis workflow, including loading states and error handling
@Observable
@MainActor
final class TrailAnalysisViewModel {
    
    // MARK: - Published Properties
    var detailedAnalysis: DetailedRiskAnalysis?
    var isLoading = false
    var errorMessage: String?
    var hasError = false
    
    // MARK: - Public Methods
    
    /// Analyzes the given trail information and updates the view state
    func analyzeTrail(_ trailInfo: TrailInfo, for userProfile: UserProfile? = nil) async {
        await setLoadingState(true)
        clearError()
        
        let analysis = await IntelligentRiskAnalyzer.analyzeTrail(trailInfo, for: userProfile)
        detailedAnalysis = analysis
        await setLoadingState(false)
    }
    
    /// Clears the current analysis and resets the state
    func clearAnalysis() {
        detailedAnalysis = nil
        clearError()
        isLoading = false
    }
    
    /// Clears any error state
    func clearError() {
        hasError = false
        errorMessage = nil
    }
    
    // MARK: - Computed Properties
    
    /// Indicates whether analysis data is available
    var hasAnalysis: Bool {
        detailedAnalysis != nil
    }
    
    /// Indicates whether the view should show loading state
    var shouldShowLoading: Bool {
        isLoading && detailedAnalysis == nil
    }
    
    /// Indicates whether the view should show content
    var shouldShowContent: Bool {
        !isLoading && hasAnalysis && !hasError
    }
    
    /// Provides a user-friendly description of the current state
    var currentStateDescription: String {
        if isLoading {
            return "Analyzing trail conditions and generating personalized recommendations..."
        } else if hasError {
            return "Unable to complete analysis. Please try again."
        } else if hasAnalysis {
            return "Analysis complete"
        } else {
            return "Ready to analyze"
        }
    }
    
    // MARK: - Private Methods
    
    private func setLoadingState(_ loading: Bool) async {
        isLoading = loading
    }
    
    private func handleError(_ error: Error) async {
        await setLoadingState(false)
        hasError = true
        
        // Map different error types to user-friendly messages
        switch error {
        case is DecodingError:
            errorMessage = "Unable to process trail analysis data. Please try again."
        case is URLError:
            errorMessage = "Network error occurred. Please check your connection and try again."
        default:
            errorMessage = "An unexpected error occurred while analyzing the trail. Please try again."
        }
    }
}