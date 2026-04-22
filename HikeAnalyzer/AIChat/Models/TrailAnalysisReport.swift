import Foundation

// MARK: - Always-available plain data types (no FoundationModels dependency)

struct TrailAnalysisReportData {
    let riskLevel: String
    let explanation: String
    let topHazards: [TrailHazardData]
    let gearItems: [GearItemData]
    let safetySteps: [SafetyStepData]
}

struct TrailHazardData {
    let name: String
    let detail: String
}

struct GearItemData {
    let name: String
    let reason: String
}

struct SafetyStepData {
    let action: String
}

// MARK: - @Generable structured types for FoundationModels (iOS 26+)

#if canImport(FoundationModels)
import FoundationModels

@Generable
struct TrailAnalysisReport {
    @Guide(description: "Risk level from the CoreML tool result: easy, moderate, difficult, or highRisk")
    var riskLevel: String

    @Guide(description: "2-3 sentences explaining the risk level based on the trail parameters and CoreML result")
    var explanation: String

    @Guide(description: "3-5 specific hazards the hiker should be aware of on this trail")
    var topHazards: [TrailHazard]

    @Guide(description: "4-6 essential gear items tailored to this trail's terrain and difficulty")
    var gearItems: [GearItem]

    @Guide(description: "3-5 concrete, actionable safety steps for this hike")
    var safetySteps: [SafetyStep]
}

@Generable
struct TrailHazard {
    @Guide(description: "Short hazard name, 2-4 words")
    var name: String

    @Guide(description: "One sentence describing the hazard on this specific trail")
    var detail: String
}

@Generable
struct GearItem {
    @Guide(description: "Gear item name")
    var name: String

    @Guide(description: "One sentence on why this item is important for this trail")
    var reason: String
}

@Generable
struct SafetyStep {
    @Guide(description: "One concrete actionable safety step")
    var action: String
}

extension TrailAnalysisReport {
    func toReportData() -> TrailAnalysisReportData {
        TrailAnalysisReportData(
            riskLevel: riskLevel,
            explanation: explanation,
            topHazards: topHazards.map { TrailHazardData(name: $0.name, detail: $0.detail) },
            gearItems: gearItems.map { GearItemData(name: $0.name, reason: $0.reason) },
            safetySteps: safetySteps.map { SafetyStepData(action: $0.action) }
        )
    }
}
#endif
