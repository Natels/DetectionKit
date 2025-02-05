// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DetectionKit",
    platforms: [.iOS(.v12), .macOS(.v11)],
    products: [
        .library(name: "DetectionKit", targets: ["DetectionKit"])
    ],
    targets: [
        .target(name: "DetectionKit"),
        .testTarget(
            name: "DetectorKitTests",
            dependencies: ["DetectionKit"]
        ),
    ]
)
