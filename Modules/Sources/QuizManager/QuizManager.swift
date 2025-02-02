import Foundation

public enum QuizManagerError: Error {
    case apiError(statusCode: APIResponse)
}

/*
 Like the QuizRepository so go there and read, I'm starting to get tired of
 typing :)
 */
public protocol QuizManager: Actor {
    func fetchQuizCatagories() async throws -> [QuizCategory]
    func fetchQuiz(
        for categoryId: QuizCategoryId,
        difficulty: QuizDifficulty,
        questionType: QuizType?
    ) async throws -> [UIQuizQuestion]
}
