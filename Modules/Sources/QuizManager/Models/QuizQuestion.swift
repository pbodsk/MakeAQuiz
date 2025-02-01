import Foundation

public struct QuizQuestion: Decodable, Sendable {
  public let type: QuizType
  public let difficulty: QuizDifficulty
  public let category: String
  public let question: String
  public let correctAnswer: String
  public let incorrectAnswers: [String]
}

public extension QuizQuestion {
  static var mockMultiple: Self {
    .init(
      type: .multipleChoice,
      difficulty: .easy,
      category: "Entertainment: Books",
      question: "What is the name of Sherlock Holmes's brother?",
      correctAnswer: "Mycroft Holmes",
      incorrectAnswers: [
        "Mederi Holmes",
        "Martin Holmes",
        "Herbie Hancock Holmes"
      ]
    )
  }
  
  static var mockTrueFalse: Self {
    .init(
      type: .multipleChoice,
      difficulty: .easy,
      category: "Entertainment: Books",
      question: "Is this true?",
      correctAnswer: "True",
      incorrectAnswers: [
        "False"
      ]
    )
  }
}
