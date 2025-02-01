import Foundation

public enum QuizRepositoryError: Error {
  case invalidURL
  case invalidResponse
  case invalidStatusCode(Int)
}

public protocol QuizRepository: Sendable {
  func fetchQuizCategories() async throws -> QuizCategoryResponse
  func fetchQuiz(
    for categoryId: QuizCategoryId,
    difficulty: QuizDifficulty,
    questionType: QuizType?
  ) async throws -> QuizResponse
}
