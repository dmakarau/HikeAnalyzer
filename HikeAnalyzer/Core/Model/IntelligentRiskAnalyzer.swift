//
//  IntelligentRiskAnalyzer.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import CoreML
import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

/// Enhanced risk analysis that combines Core ML predictions with AI-generated explanations and personalized recommendations
struct IntelligentRiskAnalyzer {
    
    /// Generates comprehensive risk analysis with AI-powered explanations and recommendations
    static func analyzeTrail(_ trailInfo: TrailInfo, for userProfile: UserProfile? = nil) async -> DetailedRiskAnalysis {
        let profile = userProfile ?? UserProfile(
            experienceLevel: .intermediate,
            fitnessLevel: .good,
            preferredDifficulty: nil,
            experienceDescription: "Regular hiking experience"
        )
        // Get base ML prediction using shared Core ML service
        let basePrediction = CoreMLTrailAnalyzer.predictRisk(for: trailInfo)
        
        // Check if AI-enhanced analysis is available
        if await isFoundationModelsAvailable() {
            return await generateAIEnhancedAnalysis(
                trailInfo: trailInfo,
                basePrediction: basePrediction,
                userProfile: profile
            )
        } else {
            // Return basic analysis without detailed AI features
            return DetailedRiskAnalysis(
                risk: basePrediction,
                explanation: "AI-enhanced analysis requires Apple Intelligence, which is not available on this device. Upgrade to a supported device for personalized recommendations and detailed safety guidance.",
                personalizedRecommendations: ["AI-enhanced recommendations require Apple Intelligence"],
                safetyPriorities: ["AI-powered safety analysis requires Apple Intelligence"],
                gearSuggestions: ["AI gear recommendations require Apple Intelligence"],
                isAIGenerated: false
            )
        }
    }
    
    // MARK: - Foundation Models Implementation
    
    private static func isFoundationModelsAvailable() async -> Bool {
        // Check feature flag first for demo/testing purposes
        guard FeatureFlags.shared.simulateFoundationModelsAvailable else {
            return false
        }
        
        // Then check actual device capability
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *) {
            return true
        }
        #endif
        return false
    }
    
    @available(iOS 26.0, *)
    private static func generateAIEnhancedAnalysis(
        trailInfo: TrailInfo,
        basePrediction: Risk,
        userProfile: UserProfile
    ) async -> DetailedRiskAnalysis {
        #if canImport(FoundationModels)
        do {
            let model = SystemLanguageModel()
            let session = LanguageModelSession(model: model) {
                createSystemPrompt(for: userProfile)
            }
            
            let query = createAnalysisQuery(trailInfo: trailInfo, prediction: basePrediction)
            let response = try await session.respond(to: query)
            
            return parseAIResponse(response.content, basePrediction: basePrediction)
        } catch {
            // Simple fallback when AI fails
            return createBasicAnalysis(basePrediction: basePrediction)
        }
        #else
        // AI not available
        return createBasicAnalysis(basePrediction: basePrediction)
        #endif
    }
    
    // MARK: - Fallback Analysis
    
    private static func createBasicAnalysis(basePrediction: Risk) -> DetailedRiskAnalysis {
        return DetailedRiskAnalysis(
            risk: basePrediction,
            explanation: "AI-enhanced analysis requires Apple Intelligence, which is not available on this device. Upgrade to a supported device for personalized recommendations and detailed safety guidance.",
            personalizedRecommendations: ["AI-enhanced recommendations require Apple Intelligence"],
            safetyPriorities: ["AI-powered safety analysis requires Apple Intelligence"],
            gearSuggestions: ["AI gear recommendations require Apple Intelligence"],
            isAIGenerated: false
        )
    }
    
    // MARK: - AI Prompt Generation
    
    private static func createSystemPrompt(for userProfile: UserProfile) -> String {
        """
        You are an expert hiking safety advisor and risk assessment specialist. Your role is to analyze trail conditions and provide detailed, actionable safety guidance.
        
        User Experience Level: \(userProfile.experienceLevel.description)
        Fitness Level: \(userProfile.fitnessLevel.description)
        Previous Hiking Experience: \(userProfile.experienceDescription)
        
        Provide analysis in this exact format:
        
        RISK EXPLANATION:
        [2-3 sentences explaining why this specific risk level was assigned based on the trail parameters]
        
        PERSONALIZED RECOMMENDATIONS:
        • [4-6 specific, actionable recommendations tailored to this user's experience level]
        
        SAFETY PRIORITIES:
        1. [Most critical safety consideration]
        2. [Second most important safety factor]
        3. [Third priority safety item]
        
        GEAR SUGGESTIONS:
        • [3-4 essential gear items specific to these trail conditions]
        
        Keep recommendations practical, specific, and appropriate for the user's experience level. Focus on safety without being overly cautious.
        """
    }
    
    private static func createAnalysisQuery(trailInfo: TrailInfo, prediction: Risk) -> String {
        let distance = trailInfo.distance ?? 0
        let elevation = trailInfo.elevation ?? 0
        
        return """
        Analyze this hiking trail and provide detailed safety guidance:
        
        Trail Details:
        - Distance: \(distance) kilometers
        - Elevation Gain: \(elevation) meters
        - Terrain Type: \(trailInfo.terrain.description)
        - Wildlife Danger Level: \(trailInfo.willifeDanger.description)
        - ML Risk Prediction: \(prediction.rawValue)
        
        Please provide comprehensive analysis following the format specified in your system prompt.
        """
    }
    
    // MARK: - Response Parsing
    
    private static func parseAIResponse(_ response: String, basePrediction: Risk) -> DetailedRiskAnalysis {
        // Debug: Log the raw response
        print("🔍 Raw AI Response:")
        print(response)
        print(String(repeating: "=", count: 50))
        
        let sections = parseResponseSections(response)
        
        // Multiple fallback strategies for each section
        let explanation = extractExplanation(from: sections, response: response, basePrediction: basePrediction)
        let recommendations = extractRecommendations(from: sections, response: response)
        let priorities = extractPriorities(from: sections, response: response)
        let gear = extractGearSuggestions(from: sections, response: response)
        
        // Debug logging to understand parsing issues
        print("🔍 AI Response Parsing Debug:")
        print("   Sections found: \(sections.keys.sorted())")
        print("   Explanation: \(explanation.prefix(50))...")
        print("   Recommendations count: \(recommendations.count)")
        print("   Priorities count: \(priorities.count)")
        print("   Gear count: \(gear.count)")
        
        return DetailedRiskAnalysis(
            risk: basePrediction,
            explanation: explanation,
            personalizedRecommendations: recommendations,
            safetyPriorities: priorities,
            gearSuggestions: gear,
            isAIGenerated: true
        )
    }
    
    private static func parseResponseSections(_ response: String) -> [String: String] {
        var sections: [String: String] = [:]
        let lines = response.components(separatedBy: .newlines)
        
        var currentSection = ""
        var currentContent: [String] = []
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // More flexible section header detection
            if trimmed.hasSuffix(":") && !trimmed.hasPrefix("•") && !trimmed.hasPrefix("1.") && !trimmed.hasPrefix("2.") && !trimmed.hasPrefix("3.") {
                // Save previous section
                if !currentSection.isEmpty {
                    sections[currentSection] = currentContent.joined(separator: "\n")
                }
                
                // Start new section - normalize the header
                let sectionName = String(trimmed.dropLast()).uppercased()
                currentSection = sectionName
                currentContent = []
            } else if !trimmed.isEmpty {
                currentContent.append(trimmed)
            }
        }
        
        // Save last section
        if !currentSection.isEmpty {
            sections[currentSection] = currentContent.joined(separator: "\n")
        }
        
        // Debug output to see what sections were found
        print("🔍 Parsed sections: \(sections.keys.sorted())")
        for (key, value) in sections {
            print("   \(key): \(value.prefix(50))...")
        }
        
        return sections
    }
    
    private static func parseListItems(_ text: String?) -> [String] {
        guard let text = text else { return [] }
        return text.components(separatedBy: .newlines)
            .compactMap { line in
                let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
                // More flexible bullet point detection
                if trimmed.hasPrefix("•") || trimmed.hasPrefix("-") || trimmed.hasPrefix("*") {
                    let cleaned = trimmed.replacingOccurrences(of: "^[•\\-\\*]\\s*", with: "", options: .regularExpression)
                    return cleaned.isEmpty ? nil : cleaned
                }
                // If no bullet points found, treat each non-empty line as an item
                return trimmed.isEmpty ? nil : trimmed
            }
    }
    
    private static func parseNumberedItems(_ text: String?) -> [String] {
        guard let text = text else { return [] }
        let items = text.components(separatedBy: .newlines)
            .compactMap { line in
                let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
                // More flexible numbered list detection
                if trimmed.range(of: #"^\d+\."#, options: .regularExpression) != nil {
                    return trimmed.replacingOccurrences(of: #"^\d+\.\s*"#, with: "", options: .regularExpression)
                }
                // If no numbers found, treat as regular list items
                return trimmed.isEmpty ? nil : trimmed
            }
        
        // If we got no numbered items, try parsing as regular list
        return items.isEmpty ? parseListItems(text) : items
    }
    
    // MARK: - Robust Content Extraction
    
    private static func extractExplanation(from sections: [String: String], response: String, basePrediction: Risk) -> String {
        // Try different section names
        if let explanation = sections["RISK EXPLANATION"] ?? sections["EXPLANATION"] ?? sections["RISK ANALYSIS"] {
            return explanation
        }
        
        // Try to find explanation in the first paragraph
        let paragraphs = response.components(separatedBy: "\n\n")
        for paragraph in paragraphs {
            let trimmed = paragraph.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.count > 50 && !trimmed.contains(":") {
                return trimmed
            }
        }
        
        return basePrediction.description
    }
    
    private static func extractRecommendations(from sections: [String: String], response: String) -> [String] {
        // Try different section names
        let possibleSections = ["PERSONALIZED RECOMMENDATIONS", "RECOMMENDATIONS", "PERSONALIZED ADVICE", "ADVICE"]
        
        for sectionName in possibleSections {
            if let content = sections[sectionName] {
                let items = parseListItems(content)
                if !items.isEmpty { return items }
            }
        }
        
        // Try to extract any bullet points or numbered items from the entire response
        let extractedItems = extractAnyListItems(from: response, keywords: ["recommend", "advice", "should", "consider"])
        
        return extractedItems.isEmpty ? ["Analysis complete - specific recommendations could not be parsed"] : extractedItems
    }
    
    private static func extractPriorities(from sections: [String: String], response: String) -> [String] {
        // Try different section names
        let possibleSections = ["SAFETY PRIORITIES", "PRIORITIES", "SAFETY CONCERNS", "KEY SAFETY POINTS"]
        
        for sectionName in possibleSections {
            if let content = sections[sectionName] {
                let items = parseNumberedItems(content)
                if !items.isEmpty { return items }
            }
        }
        
        // Try to extract any bullet points or numbered items from the entire response
        let extractedItems = extractAnyListItems(from: response, keywords: ["safety", "priority", "important", "critical", "danger"])
        
        return extractedItems.isEmpty ? ["General safety precautions apply"] : extractedItems
    }
    
    private static func extractGearSuggestions(from sections: [String: String], response: String) -> [String] {
        // Try different section names
        let possibleSections = ["GEAR SUGGESTIONS", "GEAR", "EQUIPMENT", "GEAR RECOMMENDATIONS"]
        
        for sectionName in possibleSections {
            if let content = sections[sectionName] {
                let items = parseListItems(content)
                if !items.isEmpty { return items }
            }
        }
        
        // Try to extract any bullet points or numbered items from the entire response
        let extractedItems = extractAnyListItems(from: response, keywords: ["gear", "equipment", "pack", "bring", "carry"])
        
        return extractedItems.isEmpty ? ["Standard hiking gear recommended"] : extractedItems
    }
    
    private static func extractAnyListItems(from text: String, keywords: [String]) -> [String] {
        let lines = text.components(separatedBy: .newlines)
        var items: [String] = []
        
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Check if it's a list item (bullet or numbered)
            if trimmed.hasPrefix("•") || trimmed.hasPrefix("-") || trimmed.hasPrefix("*") || 
               trimmed.range(of: #"^\d+\."#, options: .regularExpression) != nil {
                
                // Clean up the formatting
                let cleaned = trimmed
                    .replacingOccurrences(of: "^[•\\-\\*]\\s*", with: "", options: .regularExpression)
                    .replacingOccurrences(of: #"^\d+\.\s*"#, with: "", options: .regularExpression)
                
                if !cleaned.isEmpty {
                    items.append(cleaned)
                }
            }
        }
        
        // If no structured list found, look for sentences containing keywords
        if items.isEmpty {
            for line in lines {
                let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.count > 20 && keywords.contains(where: { trimmed.lowercased().contains($0.lowercased()) }) {
                    items.append(trimmed)
                }
            }
        }
        
        return Array(items.prefix(6)) // Limit to reasonable number
    }
}