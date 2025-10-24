//
//  DetailedRiskAnalysis.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation

/// Comprehensive risk analysis combining ML predictions with AI-generated insights
struct DetailedRiskAnalysis {
    /// Base risk level from Core ML model
    let risk: Risk
    
    /// Natural language explanation of why this risk level was assigned
    let explanation: String
    
    /// Personalized recommendations based on user profile and trail conditions
    let personalizedRecommendations: [String]
    
    /// Priority-ordered safety considerations
    let safetyPriorities: [String]
    
    /// Specific gear recommendations for these trail conditions
    let gearSuggestions: [String]
    
    /// Whether this analysis was generated using Foundation Models
    let isAIGenerated: Bool
    
    /// Timestamp when analysis was performed
    let timestamp: Date
    
    init(
        risk: Risk,
        explanation: String,
        personalizedRecommendations: [String],
        safetyPriorities: [String],
        gearSuggestions: [String],
        isAIGenerated: Bool
    ) {
        self.risk = risk
        self.explanation = explanation
        self.personalizedRecommendations = personalizedRecommendations
        self.safetyPriorities = safetyPriorities
        self.gearSuggestions = gearSuggestions
        self.isAIGenerated = isAIGenerated
        self.timestamp = Date()
    }
}

// MARK: - User Profile Support

/// User profile for personalized trail recommendations
struct UserProfile {
    let experienceLevel: ExperienceLevel
    let fitnessLevel: FitnessLevel
    let preferredDifficulty: Risk?
    let experienceDescription: String
    
    static let `default` = UserProfile(
        experienceLevel: .intermediate,
        fitnessLevel: .moderate,
        preferredDifficulty: nil,
        experienceDescription: "Regular weekend hiker"
    )
}

enum ExperienceLevel: String, CaseIterable {
    case beginner = "Beginner"
    case intermediate = "Intermediate" 
    case advanced = "Advanced"
    case expert = "Expert"
    
    var description: String {
        switch self {
        case .beginner:
            return "New to hiking, prefers well-marked trails under 5km"
        case .intermediate:
            return "Comfortable with day hikes up to 15km on various terrain"
        case .advanced:
            return "Experienced with challenging terrain and multi-day trips"
        case .expert:
            return "Highly experienced with technical routes and wilderness navigation"
        }
    }
}

enum FitnessLevel: String, CaseIterable {
    case low = "Low"
    case moderate = "Moderate"
    case good = "Good"
    case excellent = "Excellent"
    
    var description: String {
        switch self {
        case .low:
            return "Limited cardio fitness, prefers easier terrain"
        case .moderate:
            return "Regular light exercise, comfortable with moderate exertion"
        case .good:
            return "Active lifestyle, enjoys challenging physical activities"
        case .excellent:
            return "High fitness level, seeks physically demanding adventures"
        }
    }
}