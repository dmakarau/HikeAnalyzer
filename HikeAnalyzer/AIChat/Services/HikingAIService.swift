import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

final class HikingAIService {

    // Stores LanguageModelSession as Any to avoid availability annotation on stored property
    private var _session: Any?

    static var isAvailable: Bool {
        guard FeatureFlags.shared.simulateFoundationModelsAvailable else { return false }
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *) { return true }
        #endif
        return false
    }

    static var welcomeMessage: String {
        isAvailable ? ChatConstants.Welcome.aiEnabled : ChatConstants.Welcome.aiNotSupported
    }

    func sendMessage(_ text: String) async -> (content: String, report: TrailAnalysisReportData?) {
        #if canImport(FoundationModels)
        if #available(iOS 26.0, *) {
            return await sendWithFoundationModels(text)
        }
        #endif
        return (ChatConstants.Errors.notSupported, nil)
    }

    // MARK: - FoundationModels

    #if canImport(FoundationModels)
    @available(iOS 26.0, *)
    private func getSession() -> LanguageModelSession {
        if let existing = _session as? LanguageModelSession { return existing }
        let model = SystemLanguageModel()
        let session = LanguageModelSession(model: model, tools: [TrailAnalyzerTool()]) {
            ChatConstants.SystemPrompts.hikingAssistant
        }
        _session = session
        return session
    }

    @available(iOS 26.0, *)
    private func sendWithFoundationModels(_ text: String) async -> (content: String, report: TrailAnalysisReportData?) {
        do {
            let session = getSession()
            if containsTrailParameters(text) {
                let response = try await session.respond(to: text, generating: TrailAnalysisReport.self)
                return (ChatConstants.Analysis.reportReady, response.content.toReportData())
            } else {
                let response = try await session.respond(to: text)
                return (response.content, nil)
            }
        } catch {
            return (ChatConstants.Errors.connectionFailed, nil)
        }
    }
    #endif

    // MARK: - Trail parameter detection

    private func containsTrailParameters(_ message: String) -> Bool {
        let hasNumbers = message.range(of: "\\d+", options: .regularExpression) != nil
        let trailKeywords = ["km", "kilometer", "metre", "meter", "elevation", "terrain",
                             "rocky", "paved", "dirt", "sandy", "trail", "hike", "analyze", "analysis"]
        let lowercased = message.lowercased()
        return hasNumbers && trailKeywords.contains { lowercased.contains($0) }
    }
}
