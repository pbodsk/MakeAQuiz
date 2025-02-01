import Core
import Foundation

public struct QuizCategoryId: Decodable, Hashable, Sendable, ModelIdentifiable {
  public let value: Int
  
  public init(value: Int) {
    self.value = value
  }
}
