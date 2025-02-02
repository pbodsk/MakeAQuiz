import Foundation

// Representing the categories we get back when asking for all categories
public struct QuizCategory: Decodable, Sendable, Identifiable {
    /*
     I like to make strongly typed IDs instead of just reusing whatever the
     backend hands us back.
     It reduces the risk of you comparing say a TicketID with a PersonID just
     because they are both Strings (and really...they are not Strings right?
     I mean, you wouldn't lowercase an ID, or reverse it, or merge it with
     another ID)

     So...strong QuizCategoryId here it is :)
    */
    public let id: QuizCategoryId
    public let name: String
}

public extension QuizCategory {
    static var mockMusic: Self {
        .init(id: .init(value: 12), name: "Entertainment: Music")
    }

    static var mockBooks: Self {
        .init(id: .init(value: 10), name: "Entertainment: Book")
    }
}
