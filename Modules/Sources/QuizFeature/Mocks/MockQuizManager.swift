import Foundation
import QuizManager

actor MockQuizManager: QuizManager {
  
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
