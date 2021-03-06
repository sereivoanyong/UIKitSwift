// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "SwiftUIKit",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(name: "SwiftUIKit", targets: ["SwiftUIKit"])
  ],
  targets: [
    .target(name: "SwiftUIKit")
  ]
)
