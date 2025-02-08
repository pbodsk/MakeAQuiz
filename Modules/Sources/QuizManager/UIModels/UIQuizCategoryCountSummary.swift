import Foundation

public struct UIQuizCategoryCountSummary: Sendable {
    public let id: QuizCategoryId
    public let totalQuestions: Int
    public let easyQuestions: Int
    public let mediumQuestions: Int
    public let hardQuestions: Int

    public init(from response: QuizCategoryCountResponse) {
        self.id = response.categoryId
        self.totalQuestions = response.categoryQuestionCount.totalQuestionCount
        self.easyQuestions = response.categoryQuestionCount.totalEasyQuestionCount
        self.mediumQuestions = response.categoryQuestionCount.totalMediumQuestionCount
        self.hardQuestions = response.categoryQuestionCount.totalHardQuestionCount
    }
}

extension UIQuizCategoryCountSummary {
    // For mock
    public init(id: QuizCategoryId, totalQuestions: Int) {
        self.id = id
        self.totalQuestions = totalQuestions
        self.easyQuestions = totalQuestions / 3
        self.mediumQuestions = totalQuestions / 3
        self.hardQuestions = totalQuestions / 3
    }
}
