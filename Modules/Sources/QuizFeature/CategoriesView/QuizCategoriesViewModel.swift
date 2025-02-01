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
    
    private let quizManager: QuizManager
    
    @Published private(set) var viewState: ViewState
    
    init(
      quizManager: QuizManager,
      viewState: ViewState = .undefined
    ) {
      self.quizManager = quizManager
      self.viewState = viewState
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
  }
}
