import Foundation

public struct UIQuizAnswer: Identifiable, Sendable {
  public let id: UUID
  public let text: String
  
  init(text: String) {
    self.id = UUID()
    self.text = text
  }
}

public extension UIQuizAnswer {
  static var mock: Self {
    .init(text: "A Clever Answer")
  }
}
