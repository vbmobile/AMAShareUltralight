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
                 .upToNextMinor(from: "2.0.2")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "3.1.1")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralight",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-2.0.5.zip",
            checksum: "0352d528cbc9b7301c09edfb596be221c01ab73242b800ae907bc16a74f57a84"
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
