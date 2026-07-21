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
            targets: ["AMAShareUltralightBinary"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/vbmobile/AMADocModeliOS",
                 .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "2.6.181")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralight",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-2.0.7.zip",
            checksum: "44e62f16bcf46e1a8eb9fd2eb92cf6f0ae105e10878c4b881d54ba46a79f9d6b"
        ),
        .target(
            name: "AMAShareUltralightBinary",
            dependencies: [
                "AMAShareUltralight",
                .product(name: "AMADocModeliOS", package: "AMADocModeliOS"),
                .product(name: "UltralightFramework", package: "ultralight-native-sdk")
            ],
            path: "Sources/AMAShareUltralight"
        )
    ]
)
