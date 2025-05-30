// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Features/FeatureA/Package.swift

// Required import to access Package, Product, Target types from SPM
import PackageDescription

let package = Package(
  name: "FeatureA",  // PACKAGE IDENTIFIER - This exact string is used when:
  // 1. Other packages reference this: .package(path: "../FeatureA")
  // 2. In dependency declarations: .product(name: "X", package: "FeatureA")
  // 3. Main app adds package: Xcode shows "FeatureA" in package list

  platforms: [
    .iOS(.v15)  // MINIMUM PLATFORM VERSION
  ],

  products: [
    // PRODUCTS = PUBLIC API - What OTHER packages and MAIN App can access
    .library(
      name: "FeatureAModels",
      // 1. In other Package.swift: .product(name: "FeatureAModels", package: "FeatureA")
      // 2. NOT used in import statements (that's target name below)

      targets: ["FeatureAModels"]
      // 1. Array because one product can expose multiple targets
      // 2. "FeatureAModels" here is what you import in Swift files!
      // 3. In main app: import FeatureAModels (imports this target name)
    ),

    .library(
      name: "FeatureAServices",
      targets: ["FeatureAServices"]
    ),

    .library(
      name: "FeatureAUI",
      targets: ["FeatureAUI"]
    )
  ],

  dependencies: [
    // EXTERNAL PACKAGE DEPENDENCIES - packages this package needs
    // Empty array means this package is self-contained
    // Examples of what would go here:
    // .package(path: "../Core")  // To use shared models/services
    // .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.0")
    // Without declaring here, cannot use in targets below
  ],

  targets: [
    // TARGETS = ACTUAL CODE MODULES - where your Swift files live
    .target(
      name: "FeatureAModels",  // TARGET NAME - This is what you IMPORT in Swift files:
      // 1. In Swift: import FeatureAModels
      // 2. In same package: any target with this in dependencies can import
      // 3. In other packages: must use product to access this target
      // 4. In main app: import FeatureAModels (if product selected)

      path: "Sources/Models"   // PHYSICAL FOLDER LOCATION:
      // 1. All .swift files in FeatureA/Sources/Models/ belong to this target
      // 2. Subdirectories included: Sources/Models/Subfolder/File.swift
      // 3. Only .swift files are compiled (README.md ignored)
      // 4. If omitted, defaults to Sources/FeatureAModels/
    ),

    .target(
      name: "FeatureAServices",
      dependencies: [
        "FeatureAModels"
      ],
      path: "Sources/Services"
    ),

    .target(
      name: "FeatureAUI",
      dependencies: [
        "FeatureAModels",
        "FeatureAServices"
      ],
      path: "Sources/UI"
    )
  ]
)
