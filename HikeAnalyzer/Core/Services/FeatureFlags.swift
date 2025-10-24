//
//  FeatureFlags.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation

/// Feature flags for controlling app behavior and demonstrating different experiences
@Observable
@MainActor
final class FeatureFlags {
    
    // MARK: - Singleton
    static let shared = FeatureFlags()
    
    // MARK: - Master AI Toggle
    
    /// Master toggle for AI functionality - controls all AI-related features
    /// When true: Full AI experience with Foundation Models
    /// When false: Basic experience without AI features
    var isAIEnabled: Bool = true {
        didSet {
            print("🔧 AI Features: \(isAIEnabled ? "ENABLED" : "DISABLED")")
            if isAIEnabled {
                print("   ✅ Foundation Models simulation ON")
                print("   ✅ AI enhancement indicators ON")
                print("   ✅ Personalized recommendations ON")
            } else {
                print("   ❌ Foundation Models simulation OFF")
                print("   ❌ AI enhancement indicators OFF")
                print("   ❌ Using basic fallback system")
            }
        }
    }
    
    
    // MARK: - Derived Properties (Auto-computed from master toggle)
    
    /// Whether Foundation Models should be simulated as available
    var simulateFoundationModelsAvailable: Bool {
        return isAIEnabled
    }
    
    /// Whether to show AI enhancement indicators in the UI
    var showAIEnhancementIndicators: Bool {
        return true // Always show indicators to demonstrate the difference
    }
    
    /// Whether to show debugging info
    var showDebugInfo: Bool {
        return false // Keep clean for production
    }
    
    // MARK: - Private Initialization
    private init() {}
    
    // MARK: - Simple Toggle Methods
    
    /// Toggles the master AI functionality
    func toggleAI() {
        isAIEnabled.toggle()
    }
    
    /// Enables AI functionality (newest device experience)
    func enableAI() {
        isAIEnabled = true
    }
    
    /// Disables AI functionality (older device experience)
    func disableAI() {
        isAIEnabled = false
    }
}

// MARK: - Debug Information

extension FeatureFlags {
    
    /// Returns current AI status for debugging
    var debugDescription: String {
        """
        🤖 AI System Status:
        - Master AI Toggle: \(isAIEnabled ? "✅ ENABLED" : "❌ DISABLED")
        - Foundation Models: \(simulateFoundationModelsAvailable ? "✅ Available" : "❌ Unavailable")
        - Enhancement Indicators: \(showAIEnhancementIndicators ? "✅ Shown" : "❌ Hidden")
        
        Experience: \(isAIEnabled ? "🚀 Full AI Experience" : "📱 Basic Experience")
        """
    }
    
    /// Simple status for quick checks
    var status: String {
        return isAIEnabled ? "AI Enabled" : "AI Disabled"
    }
}
