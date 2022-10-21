//
//  LayoutGuide+Anchors.swift
//
//  Created by Sereivoan Yong on 10/21/22.
//

import UIKit

public typealias DirectionalXAxisEdgeAnchors = DirectionalXAxisEdges<NSLayoutXAxisAnchor>

public typealias XAxisEdgeAnchors = XAxisEdges<NSLayoutXAxisAnchor>

public typealias YAxisEdgeAnchors = YAxisEdges<NSLayoutYAxisAnchor>

public typealias DirectionalEdgeAnchors = DirectionalEdges<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>

public typealias EdgeAnchors = Edges<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>

extension LayoutGuide {

  public var directionalHorizontalAnchors: DirectionalXAxisEdgeAnchors {
    return .init(leading: leadingAnchor, trailing: trailingAnchor)
  }

  public var horizontalAnchors: XAxisEdgeAnchors {
    return .init(left: leftAnchor, right: rightAnchor)
  }

  public var verticalAnchors: YAxisEdgeAnchors {
    return .init(top: topAnchor, bottom: bottomAnchor)
  }

  public var directionalAnchors: DirectionalEdgeAnchors {
    return .init(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }

  public var anchors: EdgeAnchors {
    return .init(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
  }
}
