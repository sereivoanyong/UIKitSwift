// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "UIKitSwift",
  platforms: [
    .iOS(.v11)
  ],
  products: [
    .library(name: "UIKitSwift", targets: ["UIKitSwift"]),

    .library(name: "UIKitAdapter", targets: ["UIKitAdapter"]),
    .library(name: "DTPhotoViewerControllerAdapter", targets: ["DTPhotoViewerControllerAdapter"]),

    .library(name: "UIKitLayout", targets: ["UIKitLayout"]),

    .library(name: "UIKitExtra", targets: ["UIKitExtra"])
  ],
  dependencies: [
    .package(url: "https://github.com/tungvoduc/DTPhotoViewerController", from: "3.1.1"),
  ],
  targets: [
    .target(name: "UIKitSwift", dependencies: ["UIKitAdapter", "UIKitLayout", "UIKitExtra"]),

    .target(name: "UIKitAdapter"),
    .testTarget(name: "UIKitAdapterTests", dependencies: ["UIKitAdapter"]),
    .target(name: "DTPhotoViewerControllerAdapter", dependencies: ["UIKitAdapter", "DTPhotoViewerController"]),

    .target(name: "UIKitLayout"),

    .target(name: "UIKitExtra"),
    .testTarget(name: "UIKitExtraTests", dependencies: ["UIKitExtra"])
  ]
)
