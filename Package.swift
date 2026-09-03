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
      .upToNextMajor(from: "1.10.0")
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-custom-dump.git",
      .upToNextMajor(from: "1.7.3")
    ),
    .package(
      url: "https://github.com/capturecontext/swift-prelude.git",
      .upToNextMinor(from: "0.2.0")
    ),
    .package(
      url: "https://github.com/capturecontext/swift-generic-color.git",
      .upToNextMinor(from: "0.5.0")
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
