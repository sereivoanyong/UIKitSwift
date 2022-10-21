//
//  Edges+Constraints.swift
//
//  Created by Sereivoan Yong on 10/21/22.
//

import UIKit

// MARK: DirectionalXAxisEdgeConstraints

public typealias DirectionalXAxisEdgeConstraints = DirectionalXAxisEdges<NSLayoutConstraint>

extension DirectionalXAxisEdgesProtocol where XAxisItem == NSLayoutXAxisAnchor {

  public func constraints(
    equalTo anchors: any DirectionalXAxisEdgesProtocol<NSLayoutXAxisAnchor>,
    constants: any DirectionalXAxisEdgesProtocol<CGFloat> = DirectionalXAxisEdges<CGFloat>.zero
  ) -> DirectionalXAxisEdgeConstraints {
    return .init(
      leading: leading.constraint(equalTo: anchors.leading, constant: constants.leading),
      trailing: anchors.trailing.constraint(equalTo: trailing, constant: constants.trailing)
    )
  }

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> DirectionalXAxisEdgeConstraints {
    return anchors.constraints(equalTo: otherAnchors)
  }
}

// MARK: XAxisEdgeConstraints

public typealias XAxisEdgeConstraints = XAxisEdges<NSLayoutConstraint>

extension XAxisEdgesProtocol where XAxisItem == NSLayoutXAxisAnchor {

  public func constraints(
    equalTo anchors: any XAxisEdgesProtocol<NSLayoutXAxisAnchor>,
    constants: any XAxisEdgesProtocol<CGFloat> = XAxisEdges<CGFloat>.zero
  ) -> XAxisEdgeConstraints {
    return .init(
      left: left.constraint(equalTo: anchors.left, constant: constants.left),
      right: anchors.right.constraint(equalTo: right, constant: constants.right)
    )
  }

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> XAxisEdgeConstraints {
    return anchors.constraints(equalTo: otherAnchors)
  }
}

// MARK: YAxisEdgeConstraints

public typealias YAxisEdgeConstraints = YAxisEdges<NSLayoutConstraint>

extension YAxisEdgesProtocol where YAxisItem == NSLayoutYAxisAnchor {

  public func constraints(
    equalTo anchors: any YAxisEdgesProtocol<NSLayoutYAxisAnchor>,
    constants: any YAxisEdgesProtocol<CGFloat> = YAxisEdges<CGFloat>.zero
  ) -> YAxisEdgeConstraints {
    return .init(
      top: top.constraint(equalTo: anchors.top, constant: constants.top),
      bottom: anchors.bottom.constraint(equalTo: bottom, constant: constants.bottom)
    )
  }

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> YAxisEdgeConstraints {
    return anchors.constraints(equalTo: otherAnchors)
  }
}

// MARK: DirectionalEdgeConstraints

public typealias DirectionalEdgeConstraints = DirectionalEdges<NSLayoutConstraint, NSLayoutConstraint>

extension DirectionalEdgesProtocol where XAxisItem == NSLayoutXAxisAnchor, YAxisItem == NSLayoutYAxisAnchor {

  public func constraints(
    equalTo anchors: any DirectionalEdgesProtocol<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>,
    constants: any DirectionalEdgesProtocol<CGFloat, CGFloat> = DirectionalEdgeInsets.zero
  ) -> DirectionalEdgeConstraints {
    return .init(
      top: top.constraint(equalTo: anchors.top, constant: constants.top),
      leading: leading.constraint(equalTo: anchors.leading, constant: constants.leading),
      bottom: anchors.bottom.constraint(equalTo: bottom, constant: constants.bottom),
      trailing: anchors.trailing.constraint(equalTo: trailing, constant: constants.trailing)
    )
  }

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> DirectionalEdgeConstraints {
    return anchors.constraints(equalTo: otherAnchors)
  }
}

// MARK: EdgeConstraints

public typealias EdgeConstraints = Edges<NSLayoutConstraint, NSLayoutConstraint>

extension EdgesProtocol where XAxisItem == NSLayoutXAxisAnchor, YAxisItem == NSLayoutYAxisAnchor {

  public func constraints(
    equalTo anchors: any EdgesProtocol<NSLayoutXAxisAnchor, NSLayoutYAxisAnchor>,
    constants: any EdgesProtocol<CGFloat, CGFloat> = EdgeInsets.zero
  ) -> EdgeConstraints {
    return .init(
      top: top.constraint(equalTo: anchors.top, constant: constants.top),
      left: left.constraint(equalTo: anchors.left, constant: constants.left),
      bottom: anchors.bottom.constraint(equalTo: bottom, constant: constants.bottom),
      right: anchors.right.constraint(equalTo: right, constant: constants.right)
    )
  }

  @inlinable
  public static func == (anchors: Self, otherAnchors: Self) -> EdgeConstraints {
    return anchors.constraints(equalTo: otherAnchors)
  }
}
