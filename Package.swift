// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PLFile",
    products: [
        .library(
            name: "PLFile",
            targets: ["PLFile"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PLFile",
            dependencies: []),
        .testTarget(
            name: "PLFileTests",
            dependencies: ["PLFile"]),
    ]
)
