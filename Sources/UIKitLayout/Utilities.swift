//
//  Utilities.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

// MARK: Layout Priority

extension UILayoutPriority: ExpressibleByFloatLiteral {
  
  public typealias FloatLiteralType = Float
  
  public init(floatLiteral value: Float) {
    self.init(rawValue: value)
  }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {

  public typealias IntegerLiteralType = Int

  public init(integerLiteral value: Int) {
    self.init(rawValue: Float(value))
  }
}

// MARK: Axis Edges

public typealias DirectionalXAxisEdgeInsets = DirectionalXAxisEdges<CGFloat>
public typealias XAxisEdgeInsets = XAxisEdges<CGFloat>
public typealias YAxisEdgeInsets = YAxisEdges<CGFloat>

// MARK: Directional Edges

public typealias DirectionalEdgeInsets = DirectionalEdges<CGFloat, CGFloat>

extension DirectionalEdgesProtocol where DirectionalXAxisItem == NSLayoutConstraint, YAxisItem == NSLayoutConstraint {

  public var constants: DirectionalEdgeInsets {
    get { map { $0.constant } }
    set { set(newValue, at: \.constant) }
  }
}

@available(iOS 11.0, *)
extension NSDirectionalEdgeInsets: DirectionalEdgesProtocol { }

@available(iOS 11.0, *)
extension NSDirectionalEdgeInsets: AdditiveArithmetic { }

// MARK: Edges

public typealias EdgeInsets = Edges<CGFloat, CGFloat>

extension EdgesProtocol where XAxisItem == NSLayoutConstraint, YAxisItem == NSLayoutConstraint {

  public var constants: EdgeInsets {
    get { map { $0.constant } }
    set { set(newValue, at: \.constant) }
  }
}

extension UIEdgeInsets: EdgesProtocol { }
extension UIEdgeInsets: AdditiveArithmetic { }

#endif
