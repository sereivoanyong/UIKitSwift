//
//  VerticalAnchors.swift
//
//  Created by Sereivoan Yong on 8/12/21.
//

import UIKit

public typealias VerticalConstraints = YAxisEdges<NSLayoutConstraint>
public typealias VerticalAnchors = YAxisEdges<NSLayoutYAxisAnchor>

extension VerticalAnchors {

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> VerticalConstraints {
    .init(
      top: anchors.top == otherAnchors.top,
      bottom: otherAnchors.bottom == anchors.bottom
    )
  }
}

extension LayoutGuide {

  @inlinable
  public var verticalAnchors: VerticalAnchors {
    .init(top: topAnchor, bottom: bottomAnchor)
  }
}
