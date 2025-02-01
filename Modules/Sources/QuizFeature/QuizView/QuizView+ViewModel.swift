import QuizManager
import SwiftUI

extension QuizView {
  @MainActor
  class ViewModel: ObservableObject {
    enum State {
      case quiz
      case completed
    }
    
    enum Action {
      case didAnswerQuestion(
        selectedAnswer: UIQuizAnswer,
        correctAnswer: UIQuizAnswer
      )
      case nextQuestion
    }
    
    @Published var questions: [UIQuizQuestion]
    @Published private(set) var state: State
    @Published private(set) var score: Int
    @Published private(set) var currentQuestionIndex = 0
    @Published private(set) var resultText: String?
    @Published private(set) var nextButtonDisabled: Bool
    
    init(
      questions: [UIQuizQuestion],
      state: State = .quiz,
      score: Int = 0
    ) {
      self.questions = questions
      self.state = state
      self.score = score
      self.nextButtonDisabled = true
    }
    
    func handle(_ action: Action) {
      switch action {
      case .didAnswerQuestion(let selectedAnswer, let correctAnswer):
        if selectedAnswer.id == correctAnswer.id {
          resultText = "That was correct, good job"
          score += 1
        } else {
          resultText = "No sorry, that was wrong...you got the next one!"
        }
        nextButtonDisabled = false
      case .nextQuestion:
        if currentQuestionIndex < questions.count - 1 {
          resultText = nil
          currentQuestionIndex += 1
          nextButtonDisabled = true
        } else {
          state = .completed
        }
      }
    }
    
    var currentQuestion: UIQuizQuestion? {
      guard currentQuestionIndex < questions.count else { return nil }
      return questions[currentQuestionIndex]
    }
  }
}
