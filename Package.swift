// swift-tools-version:5.4
import PackageDescription

let package = Package(
  name: "SwiftUIKit",
  platforms: [
    .iOS(.v9)
  ],
  products: [
    .library(name: "SwiftUIKit", targets: ["SwiftUIKit"]),
  ],
  targets: [
    .target(name: "SwiftUIKit"),
  ]
)
