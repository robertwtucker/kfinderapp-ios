// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Services",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Services",
            targets: ["Services"])
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(url: "https://github.com/nonstrict-hq/CloudStorage.git", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Services",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "CloudStorage", package: "CloudStorage")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "ServicesTests",
            dependencies: ["Services"]
        )
    ]
)
