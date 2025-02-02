import Foundation

/*
 Another UI model because we can receive both multiple choice and true/false
 questions from the backend and instead of having a single QuizQuestion model
 with a lot of optional values for either multiple or true/false questions
 I chose to go with...an enum with associated values which is then initialized
 differently for the two scenarios
 */
public enum UIQuizType: Sendable {
    case multipleChoice(correctAnswer: UIQuizAnswer, allAnswers: [UIQuizAnswer])
    case trueFalse(correctAnswer: UIQuizAnswer, incorrectAnswer: UIQuizAnswer)
    
    init(question: QuizQuestion) {
        switch question.type {
        case .multipleChoice:
            let correctAnswer = UIQuizAnswer(text: question.correctAnswer.removingPercentEncoding ?? "")
            var allAnswers: [UIQuizAnswer] = question.incorrectAnswers.map{ .init(text: $0.removingPercentEncoding ?? "") }
            allAnswers += [correctAnswer]
            
            self = .multipleChoice(
                correctAnswer: correctAnswer,
                allAnswers: allAnswers.shuffled()
            )
        case .trueFalse:
            self = .trueFalse(
                correctAnswer: UIQuizAnswer(text: question.correctAnswer),
                incorrectAnswer: UIQuizAnswer(text: question.incorrectAnswers.first ?? "")
            )
        }
    }
}
