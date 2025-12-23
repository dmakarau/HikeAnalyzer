//
//  FeatureFlags.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 02.09.25.
//

import Foundation

/// Simple feature flag for enabling/disabling Foundation Model functionality
@Observable
@MainActor
final class FeatureFlags {
    
    static let shared = FeatureFlags()
    
    /// Whether Foundation Models should be simulated as available
    /// true: Use AI-enhanced analysis with Foundation Models
    /// false: Use basic CoreML analysis only
    var simulateFoundationModelsAvailable: Bool = true
    
    private init() {}
}
