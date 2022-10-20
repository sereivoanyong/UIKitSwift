//
//  YAxisEdges.swift
//
//  Created by Sereivoan Yong on 6/4/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol YAxisEdgesProtocol<YAxisItem> {

  associatedtype YAxisItem
  
  var top: YAxisItem { get set }
  var bottom: YAxisItem { get set }
}

extension YAxisEdgesProtocol where YAxisItem: AdditiveArithmetic {

  public var vertical: YAxisItem {
    return top + bottom
  }

  public var withoutVertical: Self {
    return withVertical(top: .zero, bottom: .zero)
  }

  public func withVertical(top: YAxisItem, bottom: YAxisItem) -> Self {
    var copy = self
    copy.top = top
    copy.bottom = bottom
    return copy
  }
}

public struct YAxisEdges<YAxisItem>: YAxisEdgesProtocol {

  public var top, bottom: YAxisItem

  public init(top: YAxisItem, bottom: YAxisItem) {
    self.top = top
    self.bottom = bottom
  }

  public var all: [YAxisItem] {
    return [top, bottom]
  }
}

extension YAxisEdges: Equatable where YAxisItem: Equatable { }

extension YAxisEdges: Hashable where YAxisItem: Hashable { }

extension YAxisEdges: Decodable where YAxisItem: Decodable { }

extension YAxisEdges: Encodable where YAxisItem: Encodable { }

extension YAxisEdges: AdditiveArithmetic where YAxisItem: AdditiveArithmetic {

  public static var zero: Self {
    return .init(top: .zero, bottom: .zero)
  }

  public static func + (lhs: Self, rhs: Self) -> Self {
    return .init(top: lhs.top + rhs.top, bottom: lhs.bottom + rhs.bottom)
  }

  public static func - (lhs: Self, rhs: Self) -> Self {
    return .init(top: lhs.top - rhs.top, bottom: lhs.bottom - rhs.bottom)
  }
}

extension YAxisEdges where YAxisItem: Numeric {

  public static func * (lhs: Self, rhs: YAxisItem) -> Self {
    return .init(top: lhs.top * rhs, bottom: lhs.bottom * rhs)
  }
}

#endif
