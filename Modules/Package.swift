// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 So the idea here is to declare separate libraries for the individual features and for shared functionality
 
 In this case we have:
 
 **A Core library**
 
 Which holds "foundational" things that should be avaiable to all.
 
 **QuizFeature**
 
 Which holds the actual feature. The idea is to have a library for each feature and then have - almost - all code relevant for this feature located here. Note that I said almost...you could imagine defining a `SharedUI` library as well for instance that could be used across several Features. The `QuizFeature` has a dependency to the `QuizManager` library.

 **QuizManager**

 Which holds the Manager and the Repository. You could argue that maybe the `Manager` and the `Repository` should be in separate layers/libraries and I wouldn't argue with you :)

 **Why?**
 
 The idea is to have as little code as possible in the "app" itself and as much as possible in individual Swift Package libraries. The advantage is that you can build, work on and test the individual libraries isolated.
 */

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
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
