// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "PLFile",
    platforms: [.macOS(.v10_15)],
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
