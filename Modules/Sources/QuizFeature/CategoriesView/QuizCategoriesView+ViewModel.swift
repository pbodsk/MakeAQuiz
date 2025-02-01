import QuizManager
import SwiftUI

extension QuizCategoriesView {
  @MainActor
  class ViewModel: ObservableObject {
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
    
    private let quizManager: QuizManager
    
    @Published private(set) var viewState: ViewState
    @Published private(set) var selectedCategory: QuizCategory?
    @Published var selectedDifficulty: QuizDifficulty
    @Published var selectedType: QuizType
    @Published var apiError: Bool = false
    @Published var apiErrorText: String = ""
    @Published var sheetState: SheetState?
    
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
    
    @MainActor
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
    
    func handle(_ action: Action) {
      switch action {
      case .select(let category):
        self.selectedCategory = category
      case .startQuiz:
        guard let selectedCategory else { return }
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
