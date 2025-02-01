import Foundation

public struct QuizResponse: Decodable, Sendable {
  public let responseCode: APIResponse
  public let results: [QuizQuestion]
}
