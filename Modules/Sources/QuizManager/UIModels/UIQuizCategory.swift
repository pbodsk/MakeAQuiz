import Foundation

public struct UIQuizCategory: Sendable, Identifiable {
    public let id: QuizCategoryId
    public let name: String
    public var countSummary: UIQuizCategoryCountSummary?

    init(from quizCategory: QuizCategory) {
        self.id = quizCategory.id
        self.name = quizCategory.name
        self.countSummary = nil
    }
}

public extension UIQuizCategory {
    static var mockMusic: Self {
        .init(from: .mockMusic)
    }

    static var mockBooks: Self {
        .init(from: .mockBooks)
    }
}
