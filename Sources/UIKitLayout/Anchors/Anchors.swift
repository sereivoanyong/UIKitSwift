//
//  Anchors.swift
//
//  Created by Sereivoan Yong on 8/12/21.
//

import UIKit

public typealias Constraints = Edges<NSLayoutConstraint, NSLayoutConstraint>
public typealias Anchors = Edges<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>

extension Anchors {

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> Constraints {
    .init(
      top: anchors.top == otherAnchors.top,
      left: anchors.left == otherAnchors.left,
      bottom: otherAnchors.bottom == anchors.bottom,
      right: otherAnchors.right == anchors.right
    )
  }
}

extension LayoutGuide {

  @inlinable
  public var anchors: Anchors {
    .init(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }
}
