import QuizManager
import SwiftUI

struct QuestionView: View {
    /*
     So for this fairly simple view I choose _not_ to add a ViewModel.
     There's not a lot of logic and there are no network calls etc.
     so we can keep it simple.

     We use a callback to communicate back to the "main" view when the user
     has made a selection
     */
    let question: UIQuizQuestion
    var didAnswerQuestion: ((UIQuizAnswer, UIQuizAnswer) -> Void)?

    @State var selectedAnswer: UIQuizAnswer?
    let correctAnswer: UIQuizAnswer

    init(
        question: UIQuizQuestion,
        didAnswerQuestion: ((UIQuizAnswer, UIQuizAnswer) -> Void)?
    ) {
        self.question = question
        self.didAnswerQuestion = didAnswerQuestion
        switch question.type {
        case .multipleChoice(let correctAnswer, _):
            self.correctAnswer = correctAnswer
        case .trueFalse(let correctAnswer, _):
            self.correctAnswer = correctAnswer
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                Text(question.question)
                    .font(.title)
                    .foregroundStyle(.white)

                switch question.type {
                case .multipleChoice(let correctAnswer, let allAnswers):
                    selectionView(
                        correctAnswer: correctAnswer,
                        allAnswers: allAnswers
                    )
                case .trueFalse(let correctAnswer, let incorrectAnswer):
                    selectionView(
                        correctAnswer: correctAnswer,
                        allAnswers: [correctAnswer, incorrectAnswer]
                    )
                }
            }
            .padding(16)
            .background {
                LinearGradient(
                    gradient: .init(colors: [.blue, .red]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            .cornerRadius(12)

            Button(action: {
                submitAnswer()
            }, label: {
                Text("And that is my final answer!")
                    .padding(4)
                    .frame(maxWidth: .infinity)
            })
            .disabled(selectedAnswer == nil)
            .buttonStyle(.borderedProminent)
        }
    }

    func submitAnswer() {
        guard let selectedAnswer else { return }
        didAnswerQuestion?(selectedAnswer, correctAnswer)
    }

    func selectionView(
        correctAnswer: UIQuizAnswer,
        allAnswers: [UIQuizAnswer]
    ) -> some View {
        VStack {
            ForEach(allAnswers) { answer in
                Text(answer.text)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .border(.black)
                    .background(selectedAnswer?.id == answer.id ? .blue: .white)
                    .onTapGesture {
                        self.selectedAnswer = answer
                    }
            }
        }
    }
}

#Preview("Multiple Question") {
    QuestionView(
        question: .mockMultiple,
        didAnswerQuestion: {_, _ in }
    )
}

#Preview("True/false Question") {
    QuestionView(
        question: .mockTrueFalse,
        didAnswerQuestion: {_, _ in }
    )
}
