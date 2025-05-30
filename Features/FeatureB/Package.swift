// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.


// FeatureB/Package.swift
import PackageDescription

let package = Package(
  name: "FeatureB",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(name: "FeatureBModels", targets: ["FeatureBModels"]),
    .library(name: "FeatureBServices", targets: ["FeatureBServices"]),
    .library(name: "FeatureBUI", targets: ["FeatureBUI"])
  ],
  dependencies: [
    // Add FeatureA as a dependency
    .package(path: "../FeatureA")
  ],
  targets: [
    .target(
      name: "FeatureBModels",
      dependencies: [
        // FeatureB models can use FeatureA models
        .product(name: "FeatureAModels", package: "FeatureA")
      ],
      path: "Sources/Models"
    ),
    .target(
      name: "FeatureBServices",
      dependencies: [
        "FeatureBModels",  // Internal dependency
        // FeatureB services can use FeatureA services if needed
          .product(name: "FeatureAServices", package: "FeatureA")
      ],
      path: "Sources/Services"
    ),
    .target(
      name: "FeatureBUI",
      dependencies: [
        "FeatureBModels",
        "FeatureBServices",
        // Usually UI doesn't depend on other feature's UI
        // But you could add if needed:
        // .product(name: "FeatureAUI", package: "FeatureA")
      ],
      path: "Sources/UI"
    )
  ]
)
