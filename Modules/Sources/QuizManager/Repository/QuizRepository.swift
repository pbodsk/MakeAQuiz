import Foundation

public enum QuizRepositoryError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
}

/*
 So the idea here and in the Manager is to introduce an interface that someone
 can then conform too...classic OO stuff where the user/caller just relies on
 the protocol and the actual _how_ can then be swapped out depending on the
 scenario ("live", preview or test)
 */
public protocol QuizRepository: Sendable {
    func fetchQuizCategories() async throws -> QuizCategoryResponse
    func fetchQuiz(
        for categoryId: QuizCategoryId,
        difficulty: QuizDifficulty,
        questionType: QuizType?
    ) async throws -> QuizResponse
    func fetchQuestionCount(
        for categoryId: QuizCategoryId
    ) async throws -> QuizCategoryCountResponse
}
