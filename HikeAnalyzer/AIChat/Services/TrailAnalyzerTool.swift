import Foundation

#if canImport(FoundationModels)
import FoundationModels

struct TrailAnalyzerTool: Tool {
    let name = "analyzeTrail"
    let description = "Runs the on-device CoreML model to predict the risk level of a hiking trail. Call this whenever the user provides trail parameters: distance, elevation, terrain type, and/or wildlife danger level."

    @Generable
    struct Arguments {
        @Guide(description: "Trail distance in kilometers as an integer, e.g. 12")
        var distance: Int

        @Guide(description: "Elevation gain in meters as an integer, e.g. 900")
        var elevation: Int

        @Guide(description: "Terrain type — must be one of: paved, dirt, rocky, sandy")
        var terrain: String

        @Guide(description: "Wildlife danger level — must be: low or high")
        var wildlifeDanger: String
    }

    nonisolated func call(arguments: Arguments) async throws -> String {
        let terrain = Terrain(rawValue: arguments.terrain) ?? .dirt
        let wildlife = arguments.wildlifeDanger.lowercased() == "high" ? WildlifeDanger.high : WildlifeDanger.low
        let trailInfo = TrailInfo(
            distance: arguments.distance,
            elevation: arguments.elevation,
            terrain: terrain,
            willifeDanger: wildlife
        )
        let risk = CoreMLTrailAnalyzer.predictRisk(for: trailInfo)
        return "CoreML risk prediction: \(risk.rawValue). \(risk.description)"
    }
}
#endif
