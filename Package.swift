// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "SwiftUIKit",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(name: "SwiftUIKit", targets: ["SwiftUIKit"]),
    .library(name: "MagazineLayoutHelper", targets: ["MagazineLayoutHelper"])
  ],
  dependencies: [
    .package(url: "https://github.com/airbnb/MagazineLayout", from: "1.6.3")
  ],
  targets: [
    .target(name: "SwiftUIKit"),
    .target(name: "MagazineLayoutHelper", dependencies: ["SwiftUIKit", "MagazineLayout"]),
  ]
)
