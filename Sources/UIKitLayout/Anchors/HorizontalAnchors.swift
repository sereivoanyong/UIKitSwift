//
//  HorizontalAnchors.swift
//
//  Created by Sereivoan Yong on 8/12/21.
//

import UIKit

public typealias HorizontalConstraints = XAxisEdges<NSLayoutConstraint>
public typealias HorizontalAnchors = XAxisEdges<NSLayoutXAxisAnchor>

extension HorizontalAnchors {

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> HorizontalConstraints {
    .init(
      left: anchors.left == otherAnchors.left,
      right: otherAnchors.right == anchors.right
    )
  }
}

extension LayoutGuide {

  @inlinable
  public var horizontalAnchors: HorizontalAnchors {
    .init(left: leftAnchor, right: rightAnchor)
  }
}
