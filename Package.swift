// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Animatable",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Animatable",
            targets: ["Animatable"]),
    ],
    targets: [
        .target(
            name: "Animatable",
            dependencies: []),
        .testTarget(
            name: "AnimatableTests",
            dependencies: ["Animatable"]),
    ]
)
