//
//  Edges.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol EdgesProtocol<XAxisItem, YAxisItem>: XAxisEdgesProtocol, YAxisEdgesProtocol {

  init(top: YAxisItem, left: XAxisItem, bottom: YAxisItem, right: XAxisItem)
}

extension EdgesProtocol {

  public init(horizontal: any XAxisEdgesProtocol<XAxisItem>, vertical: any YAxisEdgesProtocol<YAxisItem>) {
    self.init(top: vertical.top, left: horizontal.left, bottom: vertical.bottom, right: horizontal.right)
  }
}

extension EdgesProtocol where XAxisItem == YAxisItem {

  public typealias Item = XAxisItem

  public var all: [Item] {
    return [top, left, bottom, right]
  }

  /// `let insets = Edges<NSLayoutConstraint>(...).map { $0.constant }`
  public func map<T>(_ transform: (Item) -> T) -> Edges<T, T> {
    return .init(top: transform(top), left: transform(left), bottom: transform(bottom), right: transform(right))
  }

  public mutating func set<T>(_ edges: any EdgesProtocol<T, T>, at keyPath: WritableKeyPath<Item, T>) {
    top[keyPath: keyPath] = edges.top
    left[keyPath: keyPath] = edges.left
    bottom[keyPath: keyPath] = edges.bottom
    right[keyPath: keyPath] = edges.right
  }

  public mutating func update<T>(_ newEdges: any EdgesProtocol<T, T>, set: (inout Item, T) -> Void) {
    set(&top, newEdges.top)
    set(&left, newEdges.left)
    set(&bottom, newEdges.bottom)
    set(&right, newEdges.right)
  }

  public static func * (lhs: Self, rhs: Item) -> Self where Item: Numeric {
    return .init(top: lhs.top * rhs, left: lhs.left * rhs, bottom: lhs.bottom * rhs, right: lhs.right * rhs)
  }
}

extension EdgesProtocol where XAxisItem: AdditiveArithmetic, YAxisItem: AdditiveArithmetic {

  public static var zero: Self {
    return .init(top: .zero, left: .zero, bottom: .zero, right: .zero)
  }

  public static func + (lhs: Self, rhs: Self) -> Self {
    return .init(top: lhs.top + rhs.top, left: lhs.left + rhs.left, bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
  }

  public static func - (lhs: Self, rhs: Self) -> Self {
    return .init(top: lhs.top - rhs.top, left: lhs.left - rhs.left, bottom: lhs.bottom - rhs.bottom, right: lhs.right - rhs.right)
  }
}

public struct Edges<XAxisItem, YAxisItem>: EdgesProtocol {

  public var top: YAxisItem
  public var left: XAxisItem
  public var bottom: YAxisItem
  public var right: XAxisItem

  public init(top: YAxisItem, left: XAxisItem, bottom: YAxisItem, right: XAxisItem) {
    self.top = top
    self.left = left
    self.bottom = bottom
    self.right = right
  }
}

extension Edges: Equatable where XAxisItem: Equatable, YAxisItem: Equatable { }

extension Edges: Hashable where XAxisItem: Hashable, YAxisItem: Hashable { }

extension Edges: Decodable where XAxisItem: Decodable, YAxisItem: Decodable { }

extension Edges: Encodable where XAxisItem: Encodable, YAxisItem: Encodable { }

extension Edges: AdditiveArithmetic where XAxisItem: AdditiveArithmetic, YAxisItem: AdditiveArithmetic { }

#endif
