// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pag_darwin",
    platforms: [
        // If your plugin only supports iOS, remove `.macOS(...)`.
        // If your plugin only supports macOS, remove `.iOS(...)`.
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        // If the plugin name contains "_", replace with "-" for the library name.
        .library(name: "pag-darwin", targets: ["pag_darwin"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/libpag/pag-ios.git", from: "4.5.92"),
        .package(url: "https://github.com/yanshouwang/pag-macos.git", from: "4.5.85")
    ],
    targets: [
        .target(
            name: "pag_darwin",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "libpag", package: "pag-ios", condition: .when(platforms: [.iOS])),
                .product(name: "libpag-macOS", package: "pag-macos", condition: .when(platforms: [.macOS]))
            ],
            resources: [
                // TODO: If your plugin requires a privacy manifest
                // (e.g. if it uses any required reason APIs), update the PrivacyInfo.xcprivacy file
                // to describe your plugin's privacy impact, and then uncomment this line.
                // For more information, visit:
                // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                // .process("PrivacyInfo.xcprivacy"),

                // TODO: If you have other resources that need to be bundled with your plugin, refer to
                // the following instructions to add them:
                // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
            ]
        )
    ]
)
