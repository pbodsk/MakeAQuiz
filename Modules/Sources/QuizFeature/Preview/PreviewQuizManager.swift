import Foundation
import QuizManager

// A simple "mock" to use for previews.
// Could be extended if we want to show error and so on maybe
actor PreviewQuizManager: QuizManager {

    func fetchQuizCatagories() async throws -> [QuizCategory] {
        [
            .mockMusic,
            .mockBooks
        ]
    }

    func fetchQuiz(
        for categoryId: QuizCategoryId,
        difficulty: QuizDifficulty,
        questionType: QuizType?
    ) async throws -> [UIQuizQuestion] {
        [
            .init(from: .mockMultiple)
        ]
    }
}
