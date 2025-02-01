import Foundation
import QuizManager

actor MockQuizManager: QuizManager {
  func fetchQuizCatagories() async throws -> [QuizCategory] {
    [.mock]
  }
}
