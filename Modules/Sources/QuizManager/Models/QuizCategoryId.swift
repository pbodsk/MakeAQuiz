import Core
import Foundation

/*
 See the reason for this in the comment in `QuizCategory`
 */
public struct QuizCategoryId: Decodable, Hashable, Sendable, ModelIdentifiable {
    public let value: Int
    
    public init(value: Int) {
        self.value = value
    }
}
