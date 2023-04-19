// swift-tools-version:5.5

/**
*  FTPPublishDeploy
*  Copyright (c) Brian Dinsen 2020
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "FTPPublishDeploy",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "FTPPublishDeploy",
            targets: ["FTPPublishDeploy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/files.git", from: "4.0.0"),
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.5.0"),
        .package(url: "https://github.com/johnsundell/shellout.git", from: "2.3.0"),
    ],
    targets: [
        .target(
            name: "FTPPublishDeploy",
            dependencies: ["Files", "Publish", "ShellOut"]),
    ]
)
