import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let content: String
    let isFromUser: Bool
    let timestamp: Date
    var analysisReport: TrailAnalysisReportData?

    init(id: UUID = UUID(), content: String, isFromUser: Bool, timestamp: Date = Date(), analysisReport: TrailAnalysisReportData? = nil) {
        self.id = id
        self.content = content
        self.isFromUser = isFromUser
        self.timestamp = timestamp
        self.analysisReport = analysisReport
    }
}
