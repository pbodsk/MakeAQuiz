import QuizFeature
import SwiftUI

/*
 The start of it all.

 If you've jumped straigt to this file, expecting to find a grand explaination
 of it all, I have to disappoint you, the description is spread in the individual
 files so...if I were you I would start by taking a look at Package.swift
 to see how things are structured, and then dive into QuizCategoriesView
 and from there to the QuizCategoriesView+ViewModel to get an idea about
 the structure.

 Have fun
 */

@main
struct MakeAQuizApp: App {
    var body: some Scene {
        WindowGroup {
            QuizCategoriesView(quizManager: Dependencies.Live.quizManager)
        }
    }
}
