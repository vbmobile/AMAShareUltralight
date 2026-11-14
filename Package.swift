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
        .package(url: "https://github.com/vbmobile/AMADocModel",
                 .upToNextMinor(from: "4.3.0")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "4.2.1")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralightBinary",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-4.2.0.zip",
            checksum: "ab0ff1873252c56537c119c89bd542461f6ae81ad6b9677382b3f7fa2d360229"
        ),
        .target(
            name: "AMAShareUltralight",
            dependencies: [
                "AMAShareUltralightBinary",
                .product(name: "AMADocModel", package: "AMADocModel"),
                .product(name: "UltralightFramework", package: "ultralight-native-sdk")
            ],
            path: "Sources/AMAShareUltralight"
        )
    ]
)
