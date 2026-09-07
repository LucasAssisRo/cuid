// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CUID",
  products: [
    .library(
      name: "CUID",
      targets: ["CUID"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin.git", .upToNextMajor(from: "1.4.3")),
  ],
  targets: [
    .target(
      name: "CUID",
      dependencies: []
    ),
    .testTarget(
      name: "CUIDTests",
      dependencies: ["CUID"]
    ),
  ]
)
