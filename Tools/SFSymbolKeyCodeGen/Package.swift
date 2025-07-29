// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SFSymbolKeyCodeGen",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.0"),
    ],
    targets: [
        .executableTarget(
            name: "SFSymbolKeyCodeGen",
            dependencies: [
                .target(name: "SFSymbolKeyResource"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
        ),
        .executableTarget(
            name: "SFSymbolVersionMDGen",
            dependencies: [
                .target(name: "SFSymbolKeyResource"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
        ),
        .target(
            name: "SFSymbolKeyResource",
            resources: [.process("Resource")],
        ),
        .testTarget(
            name: "SFSymbolKeyResourceTests",
            dependencies: [
                "SFSymbolKeyResource",
            ],
        ),
    ],
)
