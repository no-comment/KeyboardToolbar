// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "KeyboardToolbar",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "KeyboardToolbar",
            targets: ["KeyboardToolbar"]
        ),
    ],
    targets: [
        .target(name: "KeyboardToolbar"),
        .testTarget(
            name: "KeyboardToolbarTests",
            dependencies: ["KeyboardToolbar"]
        ),
    ]
)
