// swift-tools-version: 6.2
import PackageDescription

let models = (
    package: "AMADocModeliOS",
    product: "AMADocModeliOS",
    url: "https://github.com/vbmobile/AMADocModeliOS",
    version: "1.0.0-rc03"
)

let ultralight = (
    package: "ultralight-native-sdk",
    product: "UltralightFramework",
    url: "https://github.com/vbmobile/ultralight-native-sdk",
    version: "2.6.141"
)

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
        .package(url: models.url, exact: .init(stringLiteral: models.version)),
        .package(url: ultralight.url, exact: .init(stringLiteral: ultralight.version))
    ],
    targets: [
        .binaryTarget(
            name: "AMAShareUltralightBinary",
            path: "Frameworks/AMAShareUltralight.xcframework"
        ),
        // ✅ Swift wrapper target that pulls remote deps + exposes the binary
        .target(
            name: "AMAShareUltralight",
            dependencies: [
                "AMAShareUltralightBinary",
                .product(name: models.product, package: models.package),
                .product(name: ultralight.product, package: ultralight.package)
            ],
            path: "Sources/AMAShareUltralight"
        )
    ]
)
