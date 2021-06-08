//
//  XAxisEdges.swift
//
//  Created by Sereivoan Yong on 6/4/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol XAxisEdgesProtocol {

  associatedtype XAxisItem
  var left: XAxisItem { get set }
  var right: XAxisItem { get set }
}

extension XAxisEdgesProtocol where XAxisItem: AdditiveArithmetic {

  public var horizontal: XAxisItem {
    left + right
  }
}

public struct XAxisEdges<Item>: XAxisEdgesProtocol {

  public var left, right: Item

  public init(left: Item, right: Item) {
    self.left = left
    self.right = right
  }
}

extension XAxisEdges: Equatable where Item: Equatable { }
extension XAxisEdges: Hashable where Item: Hashable { }
extension XAxisEdges: Decodable where Item: Decodable { }
extension XAxisEdges: Encodable where Item: Encodable { }

extension XAxisEdges: AdditiveArithmetic where Item: AdditiveArithmetic {

  @inlinable
  public static var zero: Self {
    .init(left: .zero, right: .zero)
  }

  @inlinable
  public static func + (lhs: Self, rhs: Self) -> Self {
    .init(left: lhs.left + rhs.left, right: lhs.right + rhs.right)
  }

  @inlinable
  public static func - (lhs: Self, rhs: Self) -> Self {
    .init(left: lhs.left - rhs.left, right: lhs.right - rhs.right)
  }
}

#endif
