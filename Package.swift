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
                 .upToNextMinor(from: "4.1.1")),
        .package(url: "https://github.com/vbmobile/ultralight-native-sdk",
                 exact: "3.3.4")
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralightBinary",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-4.0.0.zip",
            checksum: "b84a8594bc402ac487f5d4544a01fbf8df85ea7e60aa19c584622d963a25d59c"
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
