import Foundation

/*
 So the idea about Managers is that they are the ones responsible for communi-
 cating with the outside world, they are also the ones who hold shared state
 (not needed in this case) and all those things.

 I've chosen go to with an Actor here to ensure concurrency since the Manager
 is created in the Dependencies enum where we create one LiveQuizManager
 that is then passed to everyone who needs a QuizManager. Therefore it is
 a good idea to ensure that only one caller at the time uses the manager.
 */
public actor LiveQuizManager {
    // This is where Swift 6 concurrency started to be a pain :)
    private nonisolated let repository: QuizRepository

    // Again...protocols here so we can pass in the NetworkQuizRepository
    // in "live" and other mock/previews in other scenarios if needed
    public init(repository: QuizRepository) {
        self.repository = repository
    }
}

extension LiveQuizManager: QuizManager {
    /*
     So here is where we can convert from the API "world" to our apps needs
     For instance here we sort them alphabetically
     */
    public func fetchQuizCatagories() async throws -> [UIQuizCategory] {
        try await repository
            .fetchQuizCategories()
            .triviaCategories
            .map { UIQuizCategory(from: $0) }
            .sorted(by: { $0.name < $1.name} )
    }

    public func fetchCategoryCounts(
        for categoryIds: [QuizCategoryId]
    ) throws -> AsyncStream<UIQuizCategoryCountSummary> {
        AsyncStream { continuation in
            Task {
                try await withThrowingTaskGroup(of: QuizCategoryCountResponse?.self) { group in
                    for categoryId in categoryIds {
                        group.addTask(operation: { [weak self] in
                            try await self?.repository.fetchQuestionCount(for: categoryId)
                        })
                    }

                    for try await response in group {
                        if let response = response {
                            continuation.yield(
                                UIQuizCategoryCountSummary(from: response)
                            )
                        }
                    }

                    continuation.finish()
                }
            }
        }
    }

    /*
     And here we check the API result first...as mentioned in the
     NetworkQuizRepository, this _could_ and maybe should also be handled in
     the network layer but...yeah
     */
    public func fetchQuiz(
        for categoryId: QuizCategoryId,
        difficulty: QuizDifficulty,
        questionType: QuizType?
    ) async throws -> [UIQuizQuestion] {
        let result = try await repository
            .fetchQuiz(
                for: categoryId,
                difficulty: difficulty,
                questionType: questionType
            )
        guard result.responseCode == .success else {
            throw QuizManagerError.apiError(statusCode: result.responseCode)
        }
        return result.results.map {UIQuizQuestion(from: $0) }
    }
}
