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
                 .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "2.6.141")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralight",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-2.0.0.zip",
            checksum: "66bb6f7e7d6566d553905a6c4903cd5da4889982bc332490f25eb51e8dbff2ec"
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
