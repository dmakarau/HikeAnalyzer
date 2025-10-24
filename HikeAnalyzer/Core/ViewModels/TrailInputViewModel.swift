//
//  TrailInputViewModel.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation

/// ViewModel responsible for managing trail input form state and validation
@Observable
@MainActor
final class TrailInputViewModel {
    
    // MARK: - Published Properties
    var trailInfo = TrailInfo()
    var userProfile = UserProfile.default
    var validationErrors: [ValidationError] = []
    var isAnimating = false
    
    // MARK: - Computed Properties
    
    /// Indicates whether the current trail information is valid for analysis
    var isValidForAnalysis: Bool {
        validateTrailInfo().isEmpty
    }
    
    /// Provides a user-friendly validation summary
    var validationSummary: String? {
        let errors = validateTrailInfo()
        guard !errors.isEmpty else { return nil }
        
        return errors.map { $0.localizedDescription }.joined(separator: "\n")
    }
    
    /// Indicates whether the form has any validation errors
    var hasValidationErrors: Bool {
        !validationErrors.isEmpty
    }
    
    // MARK: - Public Methods
    
    /// Validates the current trail information and updates validation errors
    @discardableResult
    func validateInput() -> Bool {
        validationErrors = validateTrailInfo()
        return validationErrors.isEmpty
    }
    
    /// Clears all validation errors
    func clearValidationErrors() {
        validationErrors = []
    }
    
    /// Resets the form to default values
    func resetForm() {
        trailInfo = TrailInfo()
        userProfile = UserProfile.default
        clearValidationErrors()
    }
    
    /// Updates the animation state
    func setAnimationState(_ animating: Bool) {
        isAnimating = animating
    }
    
    /// Updates user profile settings
    func updateUserProfile(
        experienceLevel: ExperienceLevel? = nil,
        fitnessLevel: FitnessLevel? = nil,
        preferredDifficulty: Risk? = nil
    ) {
        if let experienceLevel = experienceLevel {
            userProfile = UserProfile(
                experienceLevel: experienceLevel,
                fitnessLevel: userProfile.fitnessLevel,
                preferredDifficulty: preferredDifficulty ?? userProfile.preferredDifficulty,
                experienceDescription: experienceLevel.description
            )
        }
        
        if let fitnessLevel = fitnessLevel {
            userProfile = UserProfile(
                experienceLevel: userProfile.experienceLevel,
                fitnessLevel: fitnessLevel,
                preferredDifficulty: preferredDifficulty ?? userProfile.preferredDifficulty,
                experienceDescription: userProfile.experienceDescription
            )
        }
    }
    
    // MARK: - Private Methods
    
    private func validateTrailInfo() -> [ValidationError] {
        var errors: [ValidationError] = []
        
        // Distance validation
        if let distance = trailInfo.distance {
            if distance <= 0 {
                errors.append(.invalidDistance("Distance must be greater than 0 km"))
            } else if distance > 100 {
                errors.append(.invalidDistance("Distance seems unusually high. Please verify."))
            }
        } else {
            errors.append(.missingDistance)
        }
        
        // Elevation validation
        if let elevation = trailInfo.elevation {
            if elevation < 0 {
                errors.append(.invalidElevation("Elevation gain cannot be negative"))
            } else if elevation > 5000 {
                errors.append(.invalidElevation("Elevation gain seems unusually high. Please verify."))
            }
        } else {
            errors.append(.missingElevation)
        }
        
        return errors
    }
}

// MARK: - Validation Error Types

enum ValidationError: LocalizedError {
    case missingDistance
    case invalidDistance(String)
    case missingElevation
    case invalidElevation(String)
    
    var errorDescription: String? {
        switch self {
        case .missingDistance:
            return "Distance is required"
        case .invalidDistance(let message):
            return message
        case .missingElevation:
            return "Elevation gain is required"
        case .invalidElevation(let message):
            return message
        }
    }
}