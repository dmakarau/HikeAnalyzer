//
//  HikingAIService.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation
// Note: FoundationModels is not available in current iOS versions
// This implementation provides a fallback-only system for device compatibility

/// Service responsible for generating AI responses for hiking-related queries
struct HikingAIService {
    
    /// Checks if FoundationModels is available on this device
    static var isFoundationModelsAvailable: Bool {
        // FoundationModels is not available in current iOS versions
        // This returns false to always use fallback responses
        return false
    }
    
    /// Generates an AI response for the given user message
    static func generateResponse(for message: String) async -> String {
        // Since FoundationModels is not available in current iOS versions,
        // we always use the intelligent fallback system
        return getFallbackResponse(for: message)
    }
    
    /// Provides a welcome message for new chat sessions
    static var welcomeMessage: String {
        if isFoundationModelsAvailable {
            return "Hi! I'm your AI hiking assistant powered by advanced on-device intelligence. I can help you with trail planning, safety tips, gear recommendations, and answer any hiking-related questions you might have. How can I assist you today?"
        } else {
            return "Hi! I'm your hiking assistant. While advanced AI features aren't available on this device, I can still provide helpful hiking guidance based on common questions. How can I help you plan your next adventure?"
        }
    }
    
    // MARK: - Fallback Response System
    
    /// Provides intelligent fallback responses when FoundationModels isn't available
    private static func getFallbackResponse(for userMessage: String) -> String {
        let message = userMessage.lowercased()
        
        // Safety-related questions
        if message.contains("safety") || message.contains("danger") || message.contains("risk") {
            return """
            🏔️ **Hiking Safety Essentials:**
            
            • Always inform someone of your hiking plans
            • Carry the 10 essentials: navigation, sun protection, insulation, illumination, first-aid supplies, fire, repair kit, nutrition, hydration, emergency shelter
            • Check weather conditions before departure
            • Know your limits and turn back if conditions deteriorate
            • Stay on marked trails when possible
            
            Would you like specific advice about any of these safety topics?
            """
        }
        
        // Gear-related questions
        if message.contains("gear") || message.contains("equipment") || message.contains("pack") || message.contains("what to bring") {
            return """
            🎒 **Essential Hiking Gear:**
            
            **Day Hiking:**
            • Backpack (20-30L)
            • Water (2-3 liters)
            • Snacks/lunch
            • First aid kit
            • Map and compass/GPS
            • Weather-appropriate clothing
            • Headlamp/flashlight
            
            **Multi-day Hiking:**
            Add: tent, sleeping bag, cooking gear, extra food, more water/purification
            
            What type of hike are you planning?
            """
        }
        
        // Weather-related questions
        if message.contains("weather") || message.contains("rain") || message.contains("cold") || message.contains("hot") {
            return """
            🌤️ **Weather Considerations:**
            
            • Check forecast 24-48 hours before departure
            • Layer your clothing (base, insulating, shell)
            • Bring rain gear even if clear skies predicted
            • Start early to avoid afternoon thunderstorms
            • Turn back if weather deteriorates
            • In hot weather: extra water, sun protection, early start
            • In cold weather: extra layers, emergency shelter
            
            What weather conditions are you concerned about?
            """
        }
        
        // Trail planning questions
        if message.contains("trail") || message.contains("route") || message.contains("plan") || message.contains("distance") {
            return """
            🗺️ **Trail Planning Tips:**
            
            • Research trail difficulty and length
            • Check current trail conditions and closures
            • Plan for 2-3 mph hiking speed (slower uphill)
            • Add extra time for breaks and photography
            • Have a turnaround time and stick to it
            • Consider elevation gain (1000ft = +1 hour)
            • Inform others of your specific route
            
            What type of trail are you looking to explore?
            """
        }
        
        // Beginner questions
        if message.contains("beginner") || message.contains("start") || message.contains("first time") || message.contains("new") {
            return """
            🥾 **Getting Started with Hiking:**
            
            **First Steps:**
            • Start with short, well-marked local trails
            • Build fitness gradually
            • Learn basic navigation skills
            • Practice with your gear before long hikes
            • Hike with experienced friends when possible
            
            **Good Beginner Trails:**
            • 2-4 miles total distance
            • Well-maintained paths
            • Moderate elevation gain (<1000ft)
            • Popular/well-traveled routes
            
            What's your current fitness level and experience?
            """
        }
        
        // Emergency questions
        if message.contains("emergency") || message.contains("lost") || message.contains("help") || message.contains("injured") {
            return """
            🚨 **Emergency Hiking Procedures:**
            
            **If Lost:**
            • STOP - Stay calm, Think, Observe, Plan
            • Stay put if visibility is poor
            • Signal for help (whistle 3 times, mirror)
            • Conserve energy and warmth
            
            **If Injured:**
            • Assess severity - can you self-rescue?
            • Signal for help if unable to continue
            • Use emergency communication device if available
            • Stay warm and hydrated
            
            **Prevention:**
            • Carry emergency whistle and shelter
            • Learn basic first aid
            • Carry emergency communication device
            
            Are you currently in an emergency situation?
            """
        }
        
        // General/default response
        return """
        🏔️ **I'm here to help with your hiking questions!**
        
        I can provide guidance on:
        • **Safety**: Risk assessment and emergency procedures
        • **Gear**: Equipment recommendations for different trips
        • **Planning**: Route selection and trip preparation
        • **Weather**: Conditions and appropriate responses
        • **Beginner Tips**: Getting started safely
        
        While I don't have access to advanced AI on this device, I can share proven hiking wisdom and best practices. What specific aspect of hiking would you like to discuss?
        
        *For real-time conditions and detailed route information, I recommend checking local park services and hiking apps.*
        """
    }
}
