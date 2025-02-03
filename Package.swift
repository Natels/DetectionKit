// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DetectorKit",
    platforms: [.iOS(.v12), .macOS(.v11)],
    products: [
        .library(name: "DetectorKit", targets: ["DetectorKit"])
    ],
    targets: [
        .target(name: "DetectorKit"),
        .testTarget(
            name: "DetectorKitTests",
            dependencies: ["DetectorKit"]
        ),
    ]
)
