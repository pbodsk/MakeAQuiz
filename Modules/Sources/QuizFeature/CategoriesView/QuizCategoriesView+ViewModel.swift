import QuizManager
import SwiftUI

extension QuizCategoriesView {
    @MainActor
    class ViewModel: ObservableObject {
        /*
         Another favorite of mine is to use `enum`s for a lot of things in
         my view models.

         Here you can see that I have enums for representing

         - ViewState: Which state is our view currently in?
         - Action: Which "actions" can you perform on the view
         - SheetState: Which sheets can be presented from this view
         */
        enum ViewState {
            case undefined
            case loading
            case failed
            case data([QuizCategory])

            var requiresData: Bool {
                switch self {
                case .undefined:
                    true
                case .loading, .failed, .data:
                    false
                }
            }
        }

        enum Action {
            case select(QuizCategory)
            case startQuiz
        }

        enum SheetState: Identifiable {
            case questions([UIQuizQuestion])

            var id: String {
                switch self {
                case .questions:
                    return "questions"
                }
            }
        }

        /*
         Our QuizManager who handles all data fetching for us. Just a protocol
         and then the concrete implementation is passed in in init so we can
         use different implementations for test/preview/live.

         See description of the Manager concept in LiveQuizManager
         */
        private let quizManager: QuizManager

        @Published private(set) var viewState: ViewState
        @Published private(set) var selectedCategory: QuizCategory?

        @Published var selectedDifficulty: QuizDifficulty
        @Published var selectedType: QuizType
        // These two could probably be represented by another enum ErrorState
        @Published var apiError: Bool = false
        @Published var apiErrorText: String = ""

        @Published var sheetState: SheetState?

        // I like to pass in many of these values with default values.
        // it gives you the ability to tweak the view state and so on
        // in previews
        init(
            quizManager: QuizManager,
            viewState: ViewState = .undefined,
            selectedDifficulty: QuizDifficulty = .easy,
            selectedType: QuizType = .multipleChoice
        ) {
            self.quizManager = quizManager
            self.viewState = viewState
            self.selectedDifficulty = selectedDifficulty
            self.selectedType = selectedType
        }

        // Called when the view appears to kick things off and start loading
        func onAppear() async {
            if viewState.requiresData {
                self.viewState = .loading

                do {
                    let categories = try await quizManager.fetchQuizCatagories()
                    self.viewState = .data(categories)
                } catch {
                    self.viewState = .failed
                }
            }
        }

        // A single function to handle all actions
        // Makes it easy for the views to perform actions
        // The downside is that the code inside can get out of hand but
        // then you can throw that into separate functions :)
        func handle(_ action: Action) {
            switch action {
            case .select(let category):
                self.selectedCategory = category
            case .startQuiz:
                guard let selectedCategory else { return }
                /*
                 Yeah and then there's this. Since `handle` is not async
                 we have to spin up a separate task to handle async calls.
                 You _could_ make `handle` async but then you'd always
                 have to await calls and many times you don't want that.
                 I haven't solved this in a pretty way but...this works at least
                 */
                Task {
                    do {
                        let foundQuestions = try await quizManager.fetchQuiz(
                            for: selectedCategory.id,
                            difficulty: selectedDifficulty,
                            questionType: selectedType
                        )

                        self.sheetState = .questions(foundQuestions)

                    } catch QuizManagerError.apiError(let statusCode) {
                        apiError = true
                        switch statusCode {
                        case .noResults:
                            apiErrorText = "No quizzes found, try something else"
                        default:
                            apiErrorText = "An unknown error occurred \(statusCode)"
                        }
                    }
                }
            }
        }

        var quizButtonDisabled: Bool {
            selectedCategory == nil
        }
    }
}
