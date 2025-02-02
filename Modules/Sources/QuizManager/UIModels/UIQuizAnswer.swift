import Foundation

/*
 So the idea with these UI-models is to "enrich" the raw domain models with
 things that are only relevant to the UI layer.

 For instance, I find the id part of:

 ForEach(viewModel.someItems, id: \.self)

 quite...yeah I don't like it, so I prefer to make some wrapper structs that
 conforms to Identifiable...typically just with a unique UUID in them.


 That is the case here.

 Other examples could be Date objects formatted as Strings for the frontend,
 first and last name merged in to one name....things like that
 */
public struct UIQuizAnswer: Identifiable, Sendable {
    public let id: UUID
    public let text: String
    
    init(text: String) {
        self.id = UUID()
        self.text = text
    }
}

public extension UIQuizAnswer {
    static var mock: Self {
        .init(text: "A Clever Answer")
    }
}
