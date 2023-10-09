// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MightyCombine",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MightyCombine",
            targets: [
                "MightyCombine"
            ]
        ),
        .library(
            name: "MightySwift",
            targets: [
                "MightySwift"
            ]
        ),
        .library(
            name: "MightyUIKit",
            targets: [
                "MightyUIKit"
            ]
        )
    ],
    targets: [
        
        // Product
        .target(
            name: "MightyCombine"
        ),
        .target(
            name: "MightySwift"
        ),
        .target(
            name: "MightyUIKit"
        ),
        
        // Tests
        .target(
            name: "TestSource",
            dependencies: [
                "MightyCombine"
            ]
        ),
        .testTarget(
            name: "MightyCombineTests",
            dependencies: [
                "MightyCombine",
                "TestSource"
            ]
        ),
        .testTarget(
            name: "MightySwiftTests",
            dependencies: [
                "MightySwift",
                "TestSource"
            ]
        ),
        .testTarget(
            name: "IntegrationTests",
            dependencies: [
                "MightySwift",
                "MightyCombine",
                "TestSource"
            ]
        )
    ]
)
