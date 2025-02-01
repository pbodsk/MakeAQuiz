// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
