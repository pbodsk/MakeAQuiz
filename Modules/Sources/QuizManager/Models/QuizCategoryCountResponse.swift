import Foundation

public struct QuizCategoryCountResponse: Decodable, Sendable {
    public let categoryId: QuizCategoryId
    public let categoryQuestionCount: CategoryQuestionCount
}

public struct CategoryQuestionCount: Decodable, Sendable {
    public let totalQuestionCount: Int
    public let totalEasyQuestionCount: Int
    public let totalMediumQuestionCount: Int
    public let totalHardQuestionCount: Int
}
