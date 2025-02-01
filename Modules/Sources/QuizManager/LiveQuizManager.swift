import Foundation

public actor LiveQuizManager {
  private nonisolated let repository: QuizRepository
  
  public init(repository: QuizRepository) {
    self.repository = repository
  }
}

extension LiveQuizManager: QuizManager {
  public func fetchQuizCatagories() async throws -> [QuizCategory] {
    try await repository
      .fetchQuizCategories()
      .triviaCategories
      .sorted(by: { $0.name < $1.name} )
  }
  
  public func fetchQuiz(
    for categoryId: QuizCategoryId,
    difficulty: QuizDifficulty,
    questionType: QuizType?
  ) async throws -> [UIQuizQuestion] {
    let result = try await repository
      .fetchQuiz(
        for: categoryId,
        difficulty: difficulty,
        questionType: questionType
      )
    guard result.responseCode == .success else {
      throw QuizManagerError.apiError(statusCode: result.responseCode)
    }
    return result.results.map {UIQuizQuestion(from: $0) }
  }
}
