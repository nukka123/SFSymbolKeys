// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SFSymbolKeys",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "SFSymbolKeys",
            targets: ["SFSymbolKeys"],
        ),
    ],
    targets: [
        .target(
            name: "SFSymbolKeys",
        ),
        .testTarget(
            name: "SFSymbolKeysTests",
            dependencies: ["SFSymbolKeys"],
        ),
    ],
)
