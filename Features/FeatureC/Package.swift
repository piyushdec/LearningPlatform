// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FeatureC",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "FeatureCServices", targets: ["FeatureCServices"])
  ],
  dependencies: [
    .package(path: "../FeatureB")
  ],
  targets: [
    .target(
      name: "FeatureCServices",
      dependencies: [
        .product(name: "FeatureBModels", package: "FeatureB")
      ],
      path: "Sources/Services"
    )
  ]
)
