import Foundation

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
