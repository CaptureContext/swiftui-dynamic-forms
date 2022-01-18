// swift-tools-version:5.5

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
  ],
  dependencies: [
    .package(
      name: "swift-case-paths",
      url: "https://github.com/pointfreeco/swift-case-paths.git",
      .upToNextMinor(from: "0.8.0")
    ),
    .package(
      name: "swift-custom-dump",
      url: "https://github.com/pointfreeco/swift-custom-dump.git",
      .upToNextMinor(from: "0.3.0")
    ),
    .package(
      name: "swift-prelude",
      url: "https://github.com/capturecontext/swift-prelude.git",
      .branch("develop")
    ),
    .package(
      name: "swift-generic-color",
      url: "https://github.com/capturecontext/swift-generic-color.git",
      .branch("main")
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
