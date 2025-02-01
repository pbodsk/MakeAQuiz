import Foundation

public enum QuizManagerError: Error {
  case apiError(statusCode: APIResponse)
}

public protocol QuizManager: Actor {
  func fetchQuizCatagories() async throws -> [QuizCategory]
  func fetchQuiz(
    for categoryId: QuizCategoryId,
    difficulty: QuizDifficulty,
    questionType: QuizType?
  ) async throws -> [UIQuizQuestion]
}
