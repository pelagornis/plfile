// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "PLFile",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "PLFile",
            targets: ["PLFile"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "PLFile",
            dependencies: []
        ),
        .testTarget(
            name: "PLFileTests",
            dependencies: ["PLFile"]
        )
    ]
)
