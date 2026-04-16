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
                 exact: "1.0.0-rc23"),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "2.6.141")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralight",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-1.0.0-rc23.zip",
            checksum: "e9b5f0613be6325398173e333ae25e65a8b7c4bd0f96abb66d8dee82925daf46"
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
