//
//  DirectionalAnchors.swift
//
//  Created by Sereivoan Yong on 8/12/21.
//

import UIKit

public typealias DirectionalConstraints = DirectionalEdges<NSLayoutConstraint, NSLayoutConstraint>
public typealias DirectionalAnchors = DirectionalEdges<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>

extension DirectionalAnchors {

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> DirectionalConstraints {
    .init(
      top: anchors.top == otherAnchors.top,
      leading: anchors.leading == otherAnchors.leading,
      bottom: otherAnchors.bottom == anchors.bottom,
      trailing: otherAnchors.trailing == anchors.trailing
    )
  }
}

extension LayoutGuide {

  @inlinable
  public var directionalAnchors: DirectionalAnchors {
    .init(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }
}
