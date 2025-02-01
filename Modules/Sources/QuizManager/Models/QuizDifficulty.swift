import Foundation

public enum QuizDifficulty: String, RawRepresentable, CaseIterable, Decodable, Sendable {
  case easy
  case medium
  case hard
}
