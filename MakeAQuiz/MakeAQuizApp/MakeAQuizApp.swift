import QuizFeature
import SwiftUI

@main
struct MakeAQuizApp: App {
    var body: some Scene {
        WindowGroup {
          QuizCategoriesView(quizManager: Dependencies.Live.quizManager)
        }
    }
}
