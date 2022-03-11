// swift-tools-version:5.5
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
