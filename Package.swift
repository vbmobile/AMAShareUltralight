// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "AmaShareUltralight",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AmaShareUltralight",
            targets: ["AmaShareUltralight"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AmaShareUltralight",
            url: "https://vbmobileidstorage.blob.core.windows.net/ios/AmaShareUltralight/AmaShareUltralight-1.0.0-rc01.zip",
            checksum: "7d501bda28e855d4fa8a6e6d55cbce2c5bb633bb776a69d473b335987e302f36"
        )
    ]
)
