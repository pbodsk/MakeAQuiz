import Foundation

// Aaaaand yet another enum wrapping JSON values to make it easy for us to work here
public enum QuizType: String, Codable, RawRepresentable, CaseIterable, Sendable {
    case multipleChoice = "multiple"
    case trueFalse = "boolean"

    public var presentationValue: String {
        switch self {
        case .multipleChoice:
            return "Multiple Choice"
        case .trueFalse:
            return "True or False"
        }
    }
}
