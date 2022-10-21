//
//  DirectionalEdges.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol DirectionalEdgesProtocol<XAxisItem, YAxisItem>: DirectionalXAxisEdgesProtocol, YAxisEdgesProtocol {

  init(top: YAxisItem, leading: XAxisItem, bottom: YAxisItem, trailing: XAxisItem)
}

extension DirectionalEdgesProtocol {

  public init(horizontal: any DirectionalXAxisEdgesProtocol<XAxisItem>, vertical: any YAxisEdgesProtocol<YAxisItem>) {
    self.init(top: vertical.top, leading: horizontal.leading, bottom: vertical.bottom, trailing: horizontal.trailing)
  }
}

extension DirectionalEdgesProtocol where XAxisItem == YAxisItem {

  public typealias Item = XAxisItem

  public var all: [Item] {
    return [top, leading, bottom, trailing]
  }

  /// `let insets = DirectionalEdges<NSLayoutConstraint>(...).map { $0.constant }`
  public func map<T>(_ transform: (Item) -> T) -> DirectionalEdges<T, T> {
    return .init(top: transform(top), leading: transform(leading), bottom: transform(bottom), trailing: transform(trailing))
  }

  public mutating func set<T>(_ edges: any DirectionalEdgesProtocol<T, T>, at keyPath: WritableKeyPath<Item, T>) {
    top[keyPath: keyPath] = edges.top
    leading[keyPath: keyPath] = edges.leading
    bottom[keyPath: keyPath] = edges.bottom
    trailing[keyPath: keyPath] = edges.trailing
  }

  public mutating func update<T>(_ newEdges: any DirectionalEdgesProtocol<T, T>, set: (inout Item, T) -> Void) {
    set(&top, newEdges.top)
    set(&leading, newEdges.leading)
    set(&bottom, newEdges.bottom)
    set(&trailing, newEdges.trailing)
  }

  public static func * (lhs: Self, rhs: Item) -> Self where Item: Numeric {
    return .init(top: lhs.top * rhs, leading: lhs.leading * rhs, bottom: lhs.bottom * rhs, trailing: lhs.trailing * rhs)
  }
}

extension DirectionalEdgesProtocol where XAxisItem: AdditiveArithmetic, YAxisItem: AdditiveArithmetic {

  public static var zero: Self {
    return .init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
  }

  public static func + (lhs: Self, rhs: Self) -> Self {
    return .init(top: lhs.top + rhs.top, leading: lhs.leading + rhs.leading, bottom: lhs.bottom + rhs.bottom, trailing: lhs.trailing + rhs.trailing)
  }

  public static func - (lhs: Self, rhs: Self) -> Self {
    return .init(top: lhs.top - rhs.top, leading: lhs.leading - rhs.leading, bottom: lhs.bottom - rhs.bottom, trailing: lhs.trailing - rhs.trailing)
  }
}

public struct DirectionalEdges<XAxisItem, YAxisItem>: DirectionalEdgesProtocol {

  public var top: YAxisItem
  public var leading: XAxisItem
  public var bottom: YAxisItem
  public var trailing: XAxisItem

  public init(top: YAxisItem, leading: XAxisItem, bottom: YAxisItem, trailing: XAxisItem) {
    self.top = top
    self.leading = leading
    self.bottom = bottom
    self.trailing = trailing
  }
}

extension DirectionalEdges: Equatable where XAxisItem: Equatable, YAxisItem: Equatable { }

extension DirectionalEdges: Hashable where XAxisItem: Hashable, YAxisItem: Hashable { }

extension DirectionalEdges: Decodable where XAxisItem: Decodable, YAxisItem: Decodable { }

extension DirectionalEdges: Encodable where XAxisItem: Encodable, YAxisItem: Encodable { }

extension DirectionalEdges: AdditiveArithmetic where XAxisItem: AdditiveArithmetic, YAxisItem: AdditiveArithmetic { }

#endif
