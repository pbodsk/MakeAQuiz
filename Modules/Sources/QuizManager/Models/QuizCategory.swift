import Foundation

public struct QuizCategory: Decodable, Sendable, Identifiable {
  public let id: QuizCategoryId
  public let name: String
}

public extension QuizCategory {
  static var mockMusic: Self {
    .init(id: .init(value: 12), name: "Entertainment: Music")
  }
  
  static var mockBooks: Self {
    .init(id: .init(value: 10), name: "Entertainment: Book")
  }
}
