// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FeatureC",   // PACKAGE NAME - This exact string "FeatureC" is used in two places:
  // 1. When another package wants to use FeatureC:
  //    dependencies: [.package(path: "../FeatureC")]
  // 2. When referencing products from this package:
  //    .product(name: "FeatureCServices", package: "FeatureC")
  //    The "FeatureC" in package: parameter must match this name

  platforms: [.iOS(.v15)],  // Minimum iOS 15 - inherits same requirement from FeatureB

  products: [
    .library(
      name: "FeatureCServices",  // PRODUCT NAME - This exact string "FeatureCServices" is used when:
      //    Another package wants to use this specific product:
      //    dependencies: [
      //      .product(name: "FeatureCServices", package: "FeatureC")
      //    ]
      //    Must use exact string "FeatureCServices"

      targets: ["FeatureCServices"]  // Links to target below - "FeatureCServices" must match target name exactly
      // This target name is what gets imported: import FeatureCServices
    )
  ],

  dependencies: [
    .package(path: "../FeatureB")   // "FeatureB" here must match the package name in FeatureB/Package.swift
    // Allows this package to use products from FeatureB
  ],

  targets: [
    .target(
      name: "FeatureCServices",      // TARGET NAME - This becomes the import statement:
      // In any Swift file: import FeatureCServices
      // Must match the name in targets array above

      dependencies: [
        .product(
          name: "FeatureBModels",    // "FeatureBModels" must match exact product name from FeatureB's products array
          // This is NOT the package name, but the product within FeatureB

          package: "FeatureB"        // "FeatureB" must match the package name in dependencies array above (line 31)
          // Tells SPM: "Find product FeatureBModels inside package FeatureB"
        )
        // Result: Swift files in FeatureCServices target can now: import FeatureBModels
      ],

      path: "Sources/Services"       // Physical folder: FeatureC/Sources/Services/
      // All .swift files in this folder belong to FeatureCServices target
    )
  ]
)





// USAGE EXAMPLE - If FeatureD wants to use FeatureC:
// In FeatureD/Package.swift:

/*dependencies: [
  .package(path: "../FeatureC")  // Uses "FeatureC" from line 2
],
targets: [
  .target(
    name: "FeatureDModels",
    dependencies: [
      .product(
        name: "FeatureCServices",  // Uses "FeatureCServices" from line 13
        package: "FeatureC"        // Uses "FeatureC" from line 2
      )
    ]
  )
]*/
 // Then in FeatureD/Sources/Models/SomeFile.swift:
 //import FeatureCServices

