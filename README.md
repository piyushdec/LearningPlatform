
# 📦 Scalable Microapps Architecture with Swift Package Manager (SPM)

## Swift Package Manager Cheatsheet - Complete Package.swift

```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    // RULE 1: Package name - identifies this package
    name: "FeatureB",

    // RULE 2: Minimum iOS version for this package
    platforms: [
        .iOS(.v15),
        .macOS(.v12),  // Can support multiple platforms
        .watchOS(.v8)
    ],

    // RULE 3: Products - what other packages can use
    products: [
        // Library product - most common type
        .library(
            name: "FeatureBModels",      // Product name (used in dependencies)
            targets: ["FeatureBModels"]  // Target name (must match target below)
        ),
        .library(
            name: "FeatureBServices",
            targets: ["FeatureBServices"]
        ),
        .library(
            name: "FeatureBUI",
            targets: ["FeatureBUI"]
        ),
        // Can expose multiple targets in one product
        .library(
            name: "FeatureBComplete",
            targets: ["FeatureBModels", "FeatureBServices", "FeatureBUI"]
        ),
        // Executable product (for command line tools)
        .executable(
            name: "FeatureBTool",
            targets: ["FeatureBCLI"]
        )
    ],

    // RULE 4: Dependencies - packages this package needs
    dependencies: [
        // Local package dependency (most common in microapps)
        .package(path: "../FeatureA"),
        .package(path: "../Core"),

        // Remote package dependency with exact version
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.0"),

        // Remote package with version range
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),

        // Remote package with version range (up to next major)
        .package(url: "https://github.com/realm/SwiftLint.git", .upToNextMajor(from: "0.50.0")),

        // Remote package with branch
        .package(url: "https://github.com/example/SomePackage.git", branch: "main"),

        // Remote package with commit
        .package(url: "https://github.com/example/Other.git", revision: "abc123")
    ],

    // RULE 5: Targets - actual code modules
    targets: [
        // Regular target with dependencies
        .target(
            name: "FeatureBModels",  // This is what you import in Swift files
            dependencies: [
                // Depend on product from another package
                .product(name: "FeatureAModels", package: "FeatureA"),
                .product(name: "CoreModels", package: "Core"),

                // Depend on remote package
                .product(name: "SwiftyJSON", package: "SwiftyJSON")
            ],
            path: "Sources/Models",  // Custom path (default would be Sources/FeatureBModels)
            exclude: ["README.md", "Internal/"],  // Exclude files/folders
            sources: ["Models/", "DTOs/"],  // Specific source folders (rare)
            resources: [
                // Include resources
                .process("Resources/"),  // Processed by Xcode
                .copy("Assets/")  // Copied as-is
            ],
            publicHeadersPath: "include",  // For C/ObjC targets
            cSettings: [  // C language settings
                .headerSearchPath("include"),
                .define("DEBUG", .when(configuration: .debug))
            ],
            swiftSettings: [  // Swift compiler settings
                .define("FEATURE_FLAG", .when(configuration: .debug)),
                .unsafeFlags(["-Xfrontend", "-warn-long-function-bodies=200"])
            ]
        ),

        // Target with internal dependencies only
        .target(
            name: "FeatureBServices",
            dependencies: [
                // Internal dependency (no .product needed)
                "FeatureBModels",

                // External dependencies
                .product(name: "FeatureAServices", package: "FeatureA"),
                .product(name: "CoreServices", package: "Core"),
                .product(name: "Alamofire", package: "Alamofire")
            ],
            path: "Sources/Services"
        ),

        // UI target example
        .target(
            name: "FeatureBUI",
            dependencies: [
                // Internal dependencies
                "FeatureBModels",
                "FeatureBServices",

                // Usually don't depend on other UI, but can if needed
                .product(name: "CoreUI", package: "Core")
                // Typically DON'T do this: .product(name: "FeatureAUI", package: "FeatureA")
            ],
            path: "Sources/UI",
            resources: [
                // UI often needs resources
                .process("Resources/Colors.xcassets"),
                .process("Resources/Images.xcassets"),
                .copy("Resources/Animations/")
            ]
        ),

        // Executable target (command line tool)
        .executableTarget(
            name: "FeatureBCLI",
            dependencies: ["FeatureBServices"],
            path: "Sources/CLI"
        ),

        // Test target
        .testTarget(
            name: "FeatureBTests",
            dependencies: [
                // Test your own targets
                "FeatureBModels",
                "FeatureBServices",
                "FeatureBUI",

                // Can add test-specific dependencies
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble")
            ],
            path: "Tests/FeatureBTests",
            resources: [
                .copy("TestResources/")  // Test fixtures
            ]
        ),

        // Binary target (pre-compiled framework)
        .binaryTarget(
            name: "SomeBinaryFramework",
            path: "Frameworks/SomeFramework.xcframework"
        ),

        // Binary target from URL
        .binaryTarget(
            name: "RemoteBinary",
            url: "https://example.com/framework.zip",
            checksum: "abc123..."
        ),

        // Plugin target (build tools, linters, etc.)
        .plugin(
            name: "FeatureBPlugin",
            capability: .buildTool(),
            dependencies: []
        )
    ]
)
```

## 🧠 Common Patterns & Gotchas

```swift
// 1. IMPORT RULES:
//    - In Package.swift: Use PRODUCT names in dependencies
//    - In Swift files: Use TARGET names in import statements

// 2. DEPENDENCY RULES:
//    - External package: .product(name: "ProductName", package: "PackageName")
//    - Internal target: Just use "TargetName" as string

// 3. PATH DEFAULTS:
//    - If no path specified: Sources/[TargetName]/
//    - If path specified: path/

// 4. BEST PRACTICES:
//    - Keep Product name = Target name (avoids confusion)
//    - Use specific names like "FeatureBModels" not generic "Models"
//    - Models → Services → UI (dependency direction)
//    - Don't create circular dependencies

// 5. WHAT YOU CAN'T DO:
//    - FeatureA depends on FeatureB AND FeatureB depends on FeatureA (circular)
//    - Import a target that wasn't declared as dependency
//    - Use a package without declaring it in dependencies first
```

## ✅ Quick Reference Import Examples

```swift
// In FeatureB/Sources/Models/SomeModel.swift
import FeatureBModels     // ❌ Can't import yourself
import FeatureAModels     // ✅ If declared in dependencies
import CoreModels         // ✅ If declared in dependencies
import SwiftyJSON         // ✅ If declared in dependencies

// In FeatureB/Sources/Services/SomeService.swift
import FeatureBModels     // ✅ Internal dependency
import FeatureBServices   // ❌ Can't import yourself
import FeatureAServices   // ✅ If declared in dependencies
import Alamofire          // ✅ If declared in dependencies

// In FeatureB/Sources/UI/SomeView.swift
import FeatureBModels     // ✅ Internal dependency
import FeatureBServices   // ✅ Internal dependency
import FeatureBUI         // ❌ Can't import yourself
import CoreUI             // ✅ If declared in dependencies
import FeatureAUI         // ❌ Unless specifically added (usually don't)
```

## 📐 Dependency Chain Design

- Each feature/package depends only on the one before it, never the ones after it.
- It's a **one-way dependency chain**:
  - `Core` has no dependencies — it's the foundation (shared models, utilities).
  - `FeatureA` can import `Core`.
  - `FeatureB` can import `FeatureA` and `Core`.
  - `FeatureC` can import `FeatureB`, `FeatureA`, and `Core`.

**But none of them can go backward**:
- `FeatureA` cannot import `FeatureB`
- `FeatureB` cannot import `FeatureC`

## 🛠️ Xcode Quirks & Fixes

- ❗If your `FeatureC` can import `FeatureBModels` without declaring `FeatureB` as a dependency, check:
  - You may have mistakenly dragged FeatureB source folders directly into `FeatureC`.
  - Xcode can *temporarily* see all source files in the project workspace, especially if paths are not isolated cleanly.
- ✅ To fix:
  - Only add `.package` references through File → Add Packages.
  - Double-check no folders are linked or duplicated in your file inspector.
  - Run **Product → Clean Build Folder** and restart Xcode.

