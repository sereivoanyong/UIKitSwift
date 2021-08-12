//
//  DirectionalHorizontalAnchors.swift
//
//  Created by Sereivoan Yong on 8/12/21.
//

import UIKit

public typealias DirectionalHorizontalConstraints = DirectionalXAxisEdges<NSLayoutConstraint>
public typealias DirectionalHorizontalAnchors = DirectionalXAxisEdges<NSLayoutXAxisAnchor>

extension DirectionalHorizontalAnchors {

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> DirectionalHorizontalConstraints {
    .init(
      leading: anchors.leading == otherAnchors.leading,
      trailing: otherAnchors.trailing == anchors.trailing
    )
  }
}

extension LayoutGuide {

  @inlinable
  public var directionalHorizontalAnchors: DirectionalHorizontalAnchors {
    .init(leading: leadingAnchor, trailing: trailingAnchor)
  }
}
