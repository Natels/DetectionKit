// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DetectorKit",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DetectorKit",
            targets: ["DetectorKit"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DetectorKit"),
        .testTarget(
            name: "DetectorKitTests",
            dependencies: ["DetectorKit"]
        ),
    ]
)
