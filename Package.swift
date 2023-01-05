// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "swiftui-dynamic-forms",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "DynamicForms",
      targets: ["DynamicForms"]
    ),
    .library(
      name: "DynamicFormsUI",
      targets: ["DynamicFormsUI"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-case-paths.git",
      .upToNextMinor(from: "0.11.0")
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-custom-dump.git",
      .upToNextMinor(from: "0.6.1")
    ),
    .package(
      url: "https://github.com/capturecontext/swift-prelude.git",
      branch: "develop"
    ),
    .package(
      url: "https://github.com/capturecontext/swift-generic-color.git",
      branch: "main"
    )
  ],
  targets: [
    .target(
      name: "DynamicForms",
      dependencies: [
        .product(
          name: "CasePaths",
          package: "swift-case-paths"
        ),
        .product(
          name: "CustomDump",
          package: "swift-custom-dump"
        ),
        .product(
          name: "Prelude",
          package: "swift-prelude"
        ),
        .product(
          name: "GenericColor",
          package: "swift-generic-color"
        )
      ]
    ),
    .target(
      name: "DynamicFormsUI",
      dependencies: [
        .target(name: "DynamicForms")
      ]
    ),
    .testTarget(
      name: "DynamicFormsTests",
      dependencies: [
        .target(name: "DynamicForms"),
        .product(
          name: "CustomDump",
          package: "swift-custom-dump"
        )
      ]
    )
  ]
)
