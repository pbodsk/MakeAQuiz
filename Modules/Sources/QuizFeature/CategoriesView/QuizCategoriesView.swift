import QuizManager
import SwiftUI

public struct QuizCategoriesView: View {
    /*
     As you can see I use @StateObject for my ViewModels
     I like to hand all dependendies in to the View and
     then create the ViewModel myself based on those dependencies.
     */
    @StateObject private var viewModel: ViewModel

    public init(quizManager: QuizManager) {
        _viewModel = StateObject(
            wrappedValue: .init(quizManager: quizManager)
        )
    }
    
    public var body: some View {
        VStack {
            // here we're switching on the view state.
            // Makes it easy to cover all states the view can be in
            switch viewModel.viewState {
            case .undefined, .loading:
                ProgressView()
            case .failed:
                // yeah I know
                Text("Failed to load categories")
            case .data(let categories):
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Select a category")
                            .font(.title2)

                        categoryList(for: categories)
                    }
                }
                Spacer()

                difficultyView

                typeView

                Button(action: {
                    viewModel.handle(.startQuiz)
                }, label: {
                    Text("Quiz Me!")
                        .padding(4)
                        .frame(maxWidth: .infinity)
                })
                .disabled(viewModel.quizButtonDisabled)
                .buttonStyle(.borderedProminent)
            }
        }
        // Here I should probably have made an enum as well, akin to the
        // sheetState below...version 1.1 :)
        .alert(isPresented: $viewModel.apiError) {
            Alert(
                title: Text("Oh no!"),
                message: Text(viewModel.apiErrorText),
                dismissButton: .default(Text("OK"))
            )
        }
        // Again we can use an enum to cover all sheets that can be
        // presented in this view, right now it's only one but...could be more
        .sheet(item: $viewModel.sheetState, content: { state in
            switch state {
            case .questions(let questions):
                QuizView(questions: questions)
                    .interactiveDismissDisabled(true)
            }
        })
        .padding()
        .task {
            await viewModel.onAppear()
        }
    }

    /*
     I like to split isolated view chunks into separate functions in the
     same file (no need for a new view file here...it'll only ever be used here)
     Keeps the main body somewhat trimmed (and who wouldn't want that)
     */
    private func categoryList(for categories: [QuizCategory]) -> some View {
        ForEach(categories) { category in
            Button(action: {
                self.viewModel.handle(.select(category))
            }, label: {
                HStack {
                    Text(category.name)
                        .bold(viewModel.selectedCategory?.id == category.id)
                    Spacer()
                }
            })
            .buttonStyle(.plain)
        }
    }

    private var difficultyView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("A difficulty")
                .font(.title2)

            Picker("Difficulty", selection: $viewModel.selectedDifficulty) {
                ForEach(QuizDifficulty.allCases, id: \.self) { difficulty in
                    Text(difficulty.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private var typeView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("And a type")
                .font(.title2)

            Picker("Type", selection: $viewModel.selectedType) {
                ForEach(QuizType.allCases, id: \.self) { type in
                    Text(type.presentationValue)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    QuizCategoriesView(
        quizManager: PreviewQuizManager()
    )
}
