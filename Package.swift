// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "SwiftUIKit",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(name: "SwiftUIKit", targets: ["SwiftUIKit"]),

    .library(name: "UIKitAdapter", targets: ["UIKitAdapter"]),
    .library(name: "DTPhotoViewerControllerAdapter", targets: ["DTPhotoViewerControllerAdapter"]),

    .library(name: "UIKitLayout", targets: ["UIKitLayout"]),

    .library(name: "UIKitExtra", targets: ["UIKitExtra"]),

    .library(name: "CollectionViewWaterfallLayout", targets: ["CollectionViewWaterfallLayout"]),
  ],
  dependencies: [
    .package(url: "https://github.com/tungvoduc/DTPhotoViewerController", from: "3.1.1"),
  ],
  targets: [
    .target(name: "SwiftUIKit", dependencies: ["UIKitAdapter", "UIKitLayout", "UIKitExtra"]),

    .target(name: "UIKitAdapter"),
    .testTarget(name: "UIKitAdapterTests", dependencies: ["UIKitAdapter"]),
    .target(name: "DTPhotoViewerControllerAdapter", dependencies: ["UIKitAdapter", "DTPhotoViewerController"]),

    .target(name: "UIKitLayout"),

    .target(name: "UIKitExtra"),
    .testTarget(name: "UIKitExtraTests", dependencies: ["UIKitExtra"]),

    .target(name: "CollectionViewWaterfallLayout"),
  ]
)
