// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "NearJsonRpcExample",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
    ],
    dependencies: [
        .package(name: "NearJsonRpc", path: ".."),
    ],
    targets: [
        .executableTarget(
            name: "NearJsonRpcExample",
            dependencies: [
                .product(name: "NearJsonRpcClient", package: "NearJsonRpc"),
                .product(name: "NearJsonRpcTypes", package: "NearJsonRpc"),
            ],
            path: "Sources",
        ),
    ],
)
