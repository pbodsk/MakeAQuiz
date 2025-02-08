import Foundation
import QuizManager

// A simple "mock" to use for previews.
// Could be extended if we want to show error and so on maybe
actor PreviewQuizManager: QuizManager {

    func fetchQuizCatagories() async throws -> [UIQuizCategory] {
        [
            .mockMusic,
            .mockBooks
        ]
    }

    func fetchCategoryCounts(for categoryIds: [QuizCategoryId]) throws -> AsyncStream<UIQuizCategoryCountSummary> {
        AsyncStream { continuation in
            Task {
                for id in categoryIds {
                    try await Task.sleep(nanoseconds: 50_000)

                    let mock = UIQuizCategoryCountSummary.init(id: id, totalQuestions: id.value * 10)

                    continuation.yield(mock)
                }

                continuation.finish()
            }
        }
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
