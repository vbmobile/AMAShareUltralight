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
                 branch: "main")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralightBinary",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-2.0.15.zip",
            checksum: "beaa32a73ae2745a6e162e924433e43830cac119d0b9e64ca0bd487fed1f8cd1"
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
