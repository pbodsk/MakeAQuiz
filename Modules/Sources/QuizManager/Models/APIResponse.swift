import Foundation

// A simple enum to represent the response codes we get back from the API
public enum APIResponse: Int, Decodable, Sendable {
    case success = 0
    case noResults = 1
    case invalidParameter = 2
    case tokenNotFound = 3
    case tokenEmpty = 4
    case rateLimitExceeded = 5
}
