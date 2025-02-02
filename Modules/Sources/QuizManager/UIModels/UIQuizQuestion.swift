import Foundation
import SwiftUI

/*
 Again, just to conform to Identifiable.

 And then there's this which I'm not too proud about

 self.question = quizQuestion.question.removingPercentEncoding ?? ""

 (to get rid of the weird encoding from that API)

 It should probably be done elsewhere, probably in the actial QuizQuestion init
 but...here we are
 */
public struct UIQuizQuestion: Identifiable, Sendable {
    public let id: UUID
    public let type: UIQuizType
    public let difficulty: QuizDifficulty
    public let category: String
    public let question: String
    
    public init(from quizQuestion: QuizQuestion) {
        self.id = UUID()
        self.type = .init(question: quizQuestion)
        self.difficulty = quizQuestion.difficulty
        self.category = quizQuestion.category
        self.question = quizQuestion.question.removingPercentEncoding ?? ""
    }
}

public extension UIQuizQuestion {
    static var mockMultiple: Self {
        .init(from: .mockMultiple)
    }
    
    static var mockTrueFalse: Self {
        .init(from: .mockTrueFalse)
    }
}
