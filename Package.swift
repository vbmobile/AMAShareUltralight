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
    dependencies: [
        .package(url: "https://github.com/vbmobile/AMADocModeliOS",
                 .upToNextMinor(from: "2.0.2")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "3.1.1")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralightBinary",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-2.0.10.zip",
            checksum: "abf202ae0c8770eb4fbaf8a4f2d2bbb4affca53fe46644bc0afb34379de6b85a"
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
