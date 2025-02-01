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
      case .undefined, .loading:
        ProgressView()
      case .failed:
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
    .alert(isPresented: $viewModel.apiError) {
      Alert(
        title: Text("Oh no!"),
        message: Text(viewModel.apiErrorText),
        dismissButton: .default(Text("OK"))
      )
    }
    .sheet(item: $viewModel.sheetState, content: { state in
      switch state {
      case .questions(let questions):
        QuizView(questions: questions)
          .interactiveDismissDisabled(true)
      }
    })
    .padding()
    .task { @MainActor in
      await viewModel.onAppear()
    }
  }
  
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
    quizManager: MockQuizManager()
  )
}
