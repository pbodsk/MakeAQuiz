import Foundation

public actor LiveQuizManager {
  private nonisolated let repository: QuizRepository
  
  public init(repository: QuizRepository) {
    self.repository = repository
  }
}

extension LiveQuizManager: QuizManager {
  public func fetchQuizCatagories() async throws -> [QuizCategory] {
    try await repository
      .fetchQuizCategories()
      .triviaCategories
      .sorted(by: { $0.name < $1.name} )
  }
}
