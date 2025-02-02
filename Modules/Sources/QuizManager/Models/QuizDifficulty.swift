import Foundation

// Again, a wrapper for quiz difficulties...one of the joys of mapping JSON in Swift
public enum QuizDifficulty: String, RawRepresentable, CaseIterable, Decodable, Sendable {
    case easy
    case medium
    case hard
}
