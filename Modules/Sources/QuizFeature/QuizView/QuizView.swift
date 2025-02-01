import QuizManager
import SwiftUI

struct QuizView: View {
  @StateObject var viewModel: ViewModel
  @Environment(\.dismiss) private var dismiss
  
  init(questions: [UIQuizQuestion], state: ViewModel.State = .quiz) {
    _viewModel = StateObject(
      wrappedValue: .init(
        questions: questions,
        state: state
      )
    )
  }
  
  var body: some View {
    VStack {
      switch viewModel.state {
      case .quiz:
        quizView
      case .completed:
        completedView
      }
    }
    .padding(16)
  }
  
  var quizView: some View {
    VStack {
      ScrollView {
        if let currentQuestion = viewModel.currentQuestion {
          HStack {
            Text("Question number: \(viewModel.currentQuestionIndex + 1)")
              .font(.title)
            Spacer()
          }
          QuestionView(
            question: currentQuestion,
            didAnswerQuestion: {
              selectedAnswer,
              correctAnswer in
              viewModel.handle(
                .didAnswerQuestion(
                  selectedAnswer: selectedAnswer,
                  correctAnswer: correctAnswer
                )
              )
            }
          ).disabled(!viewModel.nextButtonDisabled)
        }
        if let resultText = viewModel.resultText {
          Text(resultText)
        }
      }
      HStack {
        Text("Score: ") +
        Text("\(viewModel.score)") +
        Text(" of \(viewModel.questions.count)")
        Spacer()
      }
            
      Button(
        action: {
          viewModel.handle(.nextQuestion)
        },
        label: {
          Text("On to the next one!")
            .padding(4)
            .frame(maxWidth: .infinity)
        }
      )
      .disabled(viewModel.nextButtonDisabled)
      .buttonStyle(.borderedProminent)
      
      Button(
        action: {
          dismiss()
        },
        label: {
          Text("I give up")
            .padding(4)
            .frame(maxWidth: .infinity)
        }
      )
      .buttonStyle(.bordered)

    }
  }
  
  var completedView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Well that was fun right!")
      Text("You scored \(viewModel.score) out of \(viewModel.questions.count)")
      Button("Give me another quiz", action: {
        dismiss()
      })
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  QuizView(
    questions: [.init(from: .mockMultiple)],
    state: .quiz
  )
}
