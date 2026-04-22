import Foundation

@Observable
@MainActor
final class ChatViewModel {
    var messages: [ChatMessage] = []
    var messageText = ""
    var isGeneratingResponse = false
    var hasError = false
    var errorMessage = ""

    private let service = HikingAIService()

    init() {
        messages = [ChatMessage(content: HikingAIService.welcomeMessage, isFromUser: false)]
    }

    func sendMessage() async {
        let text = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !isGeneratingResponse else { return }

        messages.append(ChatMessage(content: text, isFromUser: true))
        messageText = ""

        isGeneratingResponse = true
        clearError()

        let (content, report) = await service.sendMessage(text)
        messages.append(ChatMessage(content: content, isFromUser: false, analysisReport: report))

        isGeneratingResponse = false
    }

    func clearError() {
        hasError = false
        errorMessage = ""
    }

    var canSendMessage: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isGeneratingResponse
    }

    var shouldShowTypingIndicator: Bool {
        isGeneratingResponse
    }
}
