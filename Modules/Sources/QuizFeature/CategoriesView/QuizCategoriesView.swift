import QuizManager
import SwiftUI

public struct QuizCategoriesView: View {
  @StateObject private var viewModel: ViewModel
  
  public init(
    quizManager: QuizManager
  ) {
    _viewModel = StateObject(
      wrappedValue: .init(quizManager: quizManager)
    )
  }
  public var body: some View {
    VStack {
      switch viewModel.viewState {
      case .undefined:
        Text("Loading...")
      case .loading:
        ProgressView()
      case .failed:
        Text("Failed to load categories")
      case .data(let categories):
        List(categories) { category in
          Text(category.name)
        }
      }
    }
    .task { @MainActor in
      await viewModel.onAppear()
    }
  }
}

#Preview {
  QuizCategoriesView(
    quizManager: MockQuizManager()
  )
}
