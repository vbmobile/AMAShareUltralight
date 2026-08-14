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
            type: .dynamic,
            targets: ["AMAShareUltralight"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/vbmobile/AMADocModeliOS",
                 .upToNextMinor(from: "2.0.3")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "3.3.4")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralightBinary",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-2.0.16.zip",
            checksum: "3598ba2e830989d80c0b0daf68a9a7313f94a07648154ccfb2e9c221714ef7e5"
        ),
        .target(
            name: "AMAShareUltralight",
            dependencies: [
                "AMAShareUltralightBinary",
                .product(name: "AMADocModeliOS", package: "AMADocModeliOS"),
                .product(name: "UltralightFramework", package: "ultralight-native-sdk")
            ],
            path: "Sources/AMAShareUltralight"
        )
    ]
)
