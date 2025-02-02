import Foundation

// another wrapper for the data returned from the API
public struct QuizResponse: Decodable, Sendable {
    public let responseCode: APIResponse
    public let results: [QuizQuestion]
}
