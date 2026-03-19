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
        // ✅ MODULE NAME MUST MATCH EXACTLY `AMADocModeliOS`
        .binaryTarget(
            name: "AMADocModeliOS",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMADocModeliOS/mdi-mob-sdk-doc-model-ios-1.0.0-rc03.zip",
            checksum: "721be7c6762ed45c25907faa786764c27529f0a15476dece5099ffbf654ba2d6"
        ),

        .binaryTarget(
            name: "UltralightFramework",
            path: "Frameworks/UltralightFramework.xcframework"
        ),

        .binaryTarget(
            name: "AMAShareUltralightBin",
            path: "Frameworks/AMAShareUltralight.xcframework"
        ),

        .target(
            name: "AMAShareUltralight",
            dependencies: [
                "AMAShareUltralightBin",
                "AMADocModeliOS",
                "UltralightFramework"
            ],
            path: "Sources/AMAShareUltralight"
        )
    ]
)
