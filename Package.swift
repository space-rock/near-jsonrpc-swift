// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "NearJsonRpc",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "NearJsonRpcClient",
            targets: ["NearJsonRpcClient"],
        ),
        .library(
            name: "NearJsonRpcTypes",
            targets: ["NearJsonRpcTypes"],
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NearJsonRpcTypes",
            dependencies: [],
        ),
        .target(
            name: "NearJsonRpcClient",
            dependencies: ["NearJsonRpcTypes"],
        ),
        .testTarget(
            name: "NearJsonRpcTypesTests",
            dependencies: ["NearJsonRpcTypes"],
            resources: [
                .copy("Mock"),
            ],
        ),
        .testTarget(
            name: "NearJsonRpcClientTests",
            dependencies: ["NearJsonRpcClient", "NearJsonRpcTypes"],
            resources: [
                .copy("Mock"),
            ],
        ),
    ],
)
