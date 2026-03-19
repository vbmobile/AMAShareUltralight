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
        .binaryTarget(
            name: "AMAShareUltralightBin",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AMAShareUltralight/AMAShareUltralight-1.0.0-rc06.zip",
            checksum: "1e25250fb3ad60eeedad635f5b4c9149b4f127f164816e9624bd6df24905cdff"
        ),
        .target(
            name: "AMAShareUltralightBin",
            dependencies: ["AMAShareUltralight"],
            path: "Sources"
        )
    ]
)
