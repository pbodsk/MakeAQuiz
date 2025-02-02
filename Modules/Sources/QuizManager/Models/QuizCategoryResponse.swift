import Foundation

// Wrapper for the response we get from the backend
public struct QuizCategoryResponse: Decodable, Sendable {
    public let triviaCategories: [QuizCategory]
}
