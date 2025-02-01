import Foundation

public struct QuizCategory: Decodable, Sendable, Identifiable {
  public let id: QuizCategoryId
  public let name: String
}

public extension QuizCategory {
  static var mock: Self {
    .init(id: .init(value: 12), name: "Entertainment: Music")
  }
}
