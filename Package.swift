// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Math",
    products: [
        .library(name: "Math", targets: ["Math"])
    ],
    targets: [
        .target(
            name: "Math",
            path: "sources/math"),
        .testTarget(
            name: "MathTests",
            dependencies: ["Math"],
            path: "tests/math"),
    ]
)
