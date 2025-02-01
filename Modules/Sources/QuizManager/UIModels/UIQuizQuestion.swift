import Foundation
import SwiftUI

public struct UIQuizQuestion: Identifiable, Sendable {
  public let id: UUID
  public let type: UIQuizType
  public let difficulty: QuizDifficulty
  public let category: String
  public let question: String

  public init(from quizQuestion: QuizQuestion) {
    self.id = UUID()
    self.type = .init(question: quizQuestion)
    self.difficulty = quizQuestion.difficulty
    self.category = quizQuestion.category
    self.question = quizQuestion.question.removingPercentEncoding ?? ""
  }
}

public extension UIQuizQuestion {
  static var mockMultiple: Self {
    .init(from: .mockMultiple)
  }
  
  static var mockTrueFalse: Self {
    .init(from: .mockTrueFalse)
  }
}
