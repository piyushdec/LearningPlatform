// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Features/FeatureA/Package.swift

import PackageDescription

let package = Package(
  name: "FeatureA",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "FeatureAModels", targets: ["FeatureAModels"]),
    .library(name: "FeatureAServices", targets: ["FeatureAServices"]),
    .library(name: "FeatureAUI", targets: ["FeatureAUI"])
  ],
  dependencies: [
    // add other local/remote packages here
  ],
  targets: [
    .target(
      name: "FeatureAModels",
      path: "Sources/Models"
    ),
    .target(
      name: "FeatureAServices",
      dependencies: ["FeatureAModels"],
      path: "Sources/Services"
    ),
    .target(
      name: "FeatureAUI",
      dependencies: ["FeatureAModels" , "FeatureAServices"],
      path: "Sources/UI"
    )
  ]
)
