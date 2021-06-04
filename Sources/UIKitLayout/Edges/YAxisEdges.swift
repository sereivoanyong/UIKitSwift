//
//  YAxisEdges.swift
//
//  Created by Sereivoan Yong on 6/4/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol YAxisEdgesProtocol {

  associatedtype YAxisItem
  var top: YAxisItem { get set }
  var bottom: YAxisItem { get set }
}

public struct YAxisEdges<Item> {

  public var top, bottom: Item

  public init(top: Item, bottom: Item) {
    self.top = top
    self.bottom = bottom
  }
}

extension YAxisEdges: Equatable where Item: Equatable { }
extension YAxisEdges: Hashable where Item: Hashable { }
extension YAxisEdges: Decodable where Item: Decodable { }
extension YAxisEdges: Encodable where Item: Encodable { }

extension YAxisEdges: AdditiveArithmetic where Item: AdditiveArithmetic {

  @inlinable
  public static var zero: Self {
    .init(top: .zero, bottom: .zero)
  }

  @inlinable
  public static func + (lhs: Self, rhs: Self) -> Self {
    .init(top: lhs.top + rhs.top, bottom: lhs.bottom + rhs.bottom)
  }

  @inlinable
  public static func - (lhs: Self, rhs: Self) -> Self {
    .init(top: lhs.top - rhs.top, bottom: lhs.bottom - rhs.bottom)
  }
}

#endif
