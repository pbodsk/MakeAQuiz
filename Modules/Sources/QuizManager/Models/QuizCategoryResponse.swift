import Foundation

public struct QuizCategoryResponse: Decodable, Sendable {
  public let triviaCategories: [QuizCategory]  
}
