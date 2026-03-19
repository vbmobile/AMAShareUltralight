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
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-1.0.0-rc05.zip",
            checksum: "1fb07c79d1fadf8d052927260a56e6d1fb34e9c0e2dc1ff2edb0e823782a2046"
        ),
        .target(
            name: "AMAShareUltralight",
            dependencies: ["AMAShareUltralight"],
            path: "Sources"
        )
    ]
)
