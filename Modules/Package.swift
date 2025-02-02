// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 So the idea here is to declare separate libraries for the individual features and for shared functionality
 
 In this case we have:
 
 **A Core library**
 
 Here you have "foundational" things that should be avaiable to all
 
 **QuizFeature**
 
 The "quiz UI logic", that is view, viewmodel and UI stuff for the quiz
 
 **QuizManager**

 The "quiz business logic", that is domain objects, logic for fetching data from the API and so on
 
 You _could_ argue that we should have a separate .library for network functionality, or that some
 of it should be moved to the "Core" layer...and I wouldn't argue with you on that :)
 
 **Why?**
 
 I've chosen to split the code like so because it makes it easy for you as a developer to focus on a
 single part of the app. You can switch to working on just the QuizFeature and compile that part isolated
 and make sure that works by itself. And at the same time a colleague can work on another feature
 and you don't have mergeconflicts (or fewer mergeconflicts at least) in the project file
 */

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
      .library(
        name: "Core",
        targets: ["Core"]
      ),
      .library(
        name: "QuizFeature",
        targets: ["QuizFeature"]
      ),
      .library(
        name: "QuizManager",
        targets: ["QuizManager"]
      )
    ],
    dependencies: [],
    targets: [
      .target(
        name: "Core",
        dependencies: []
      ),
      .target(
        name: "QuizFeature",
        dependencies: [
          "QuizManager"
        ]
      ),
      .testTarget(
        name: "QuizFeatureTests",
        dependencies: ["QuizFeature"]
      ),
      .target(
        name: "QuizManager",
        dependencies: [
          "Core"
        ]
      ),
      .testTarget(
        name: "QuizManagerTests",
        dependencies: ["QuizManager"]
      )
    ]
)
