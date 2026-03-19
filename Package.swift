// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "AMAShareUltralight",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AMAShareUltralight",
            targets: ["AMAShareUltralight"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralight",
            path: "Frameworks/AMAShareUltralight.xcframework"
        )
    ]
)
