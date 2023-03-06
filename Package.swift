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
        .executableTarget(
            name: "PLFileExample",
            dependencies: [
                .target(name: "PLFile")
            ]
        ),
        .testTarget(
            name: "PLFileTests",
            dependencies: ["PLFile"]),
    ]
)
