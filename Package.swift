// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "MeowGraphs",
    dependencies: [
        .Package(url: "https://github.com/OpenKitten/Meow.git", majorVersion: 0)
    ]
)
