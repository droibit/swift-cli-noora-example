// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "noora-example",
  platforms: [.macOS(.v15)],
  products: [
    .executable(name: "noora-example", targets: ["NooraExample"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.7.0"),
    .package(url: "https://github.com/swiftlang/swift-subprocess", exact: "0.2.1"),
    .package(url: "https://github.com/tuist/Noora", exact: "0.53.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .executableTarget(
      name: "NooraExample",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "Subprocess", package: "swift-subprocess"),
        .product(name: "Noora", package: "Noora"),
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)
