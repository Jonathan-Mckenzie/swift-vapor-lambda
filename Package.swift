// swift-tools-version:5.2
import PackageDescription

let package = Package(
        name: "SwiftVaporLambda",
        platforms: [
            .macOS(.v10_15)
        ],
        products: [
            .executable(name: "RunLocal", targets: ["RunLocal"]),
            .executable(name: "RunLambda", targets: ["RunLambda"])
        ],
        dependencies: [
            .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
            .package(url: "https://github.com/vapor-community/vapor-aws-lambda-runtime.git", .upToNextMinor(from: "0.6.0"))
        ],
        targets: [
            .target(
                    name: "App",
                    dependencies: [
                        .product(name: "Vapor", package: "vapor")
                    ]
            ),
            .target(
                    name: "RunLocal",
                    dependencies: [
                        .target(name: "App")
                    ]
            ),
            .target(
                    name: "RunLambda",
                    dependencies: [
                        .target(name: "App"),
                        .product(name: "VaporAWSLambdaRuntime", package: "vapor-aws-lambda-runtime"),
                    ]
            ),
            .testTarget(name: "AppTests", dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
            ])
        ]
)
