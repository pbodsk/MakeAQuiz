import Foundation

public protocol QuizManager: Actor {
  func fetchQuizCatagories() async throws -> [QuizCategory]
}
