// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "plfile",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "File",
            targets: ["File"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.3.0")
    ],
    targets: [
        .target(name: "File"),
        .testTarget(
            name: "FileTests",
            dependencies: ["File"]
        )
    ]
)
