// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationBanner",
    platforms: [
        .iOS("16.0"),
        .macOS("13.0"),
        .tvOS("15.0"),
        .watchOS("8.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NotificationBanner",
            targets: ["NotificationBanner"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NotificationBanner"),

    ]
)
