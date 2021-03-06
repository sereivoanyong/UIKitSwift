//
//  Edges.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol EdgesProtocol: XAxisEdgesProtocol, YAxisEdgesProtocol {

  init(top: YAxisItem, left: XAxisItem, bottom: YAxisItem, right: XAxisItem)
}

extension EdgesProtocol {

  init<XAxisEdges: XAxisEdgesProtocol, YAxisEdges: YAxisEdgesProtocol>(
    horizontal: XAxisEdges, vertical: YAxisEdges
  ) where XAxisEdges.XAxisItem == XAxisItem, YAxisEdges.YAxisItem == YAxisItem {
    self.init(top: vertical.top, left: horizontal.left, bottom: vertical.bottom, right: horizontal.right)
  }

  /// `let insets = Edges<NSLayoutConstraint>(...).map { $0.constant }`
  public func map<Item, T>(_ transform: (Item) -> T) -> Edges<T, T> where Item == XAxisItem, Item == YAxisItem {
    .init(top: transform(top), left: transform(left), bottom: transform(bottom), right: transform(right))
  }

  public mutating func set<Item, T>(_ edges: Edges<T, T>, at keyPath: WritableKeyPath<Item, T>) where Item == XAxisItem, Item == YAxisItem {
    top[keyPath: keyPath] = edges.top
    left[keyPath: keyPath] = edges.left
    bottom[keyPath: keyPath] = edges.bottom
    right[keyPath: keyPath] = edges.right
  }

  public mutating func update<Item, T>(_ newEdges: Edges<T, T>, set: (inout Item, T) -> Void) where Item == XAxisItem, Item == YAxisItem {
    set(&top, newEdges.top)
    set(&left, newEdges.left)
    set(&bottom, newEdges.bottom)
    set(&right, newEdges.right)
  }
}

extension EdgesProtocol where XAxisItem: AdditiveArithmetic, YAxisItem: AdditiveArithmetic {

  @inlinable
  public static var zero: Self {
    .init(top: .zero, left: .zero, bottom: .zero, right: .zero)
  }

  @inlinable
  public static func + (lhs: Self, rhs: Self) -> Self {
    .init(top: lhs.top + rhs.top, left: lhs.left + rhs.left, bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
  }

  @inlinable
  public static func - (lhs: Self, rhs: Self) -> Self {
    .init(top: lhs.top - rhs.top, left: lhs.left - rhs.left, bottom: lhs.bottom - rhs.bottom, right: lhs.right - rhs.right)
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

extension Edges where XAxisItem == YAxisItem {

  @inlinable
  public var all: [XAxisItem] {
    [top, left, bottom, right]
  }
}

extension Edges: Equatable where XAxisItem: Equatable, YAxisItem: Equatable { }
extension Edges: Hashable where XAxisItem: Hashable, YAxisItem: Hashable { }
extension Edges: Decodable where XAxisItem: Decodable, YAxisItem: Decodable { }
extension Edges: Encodable where XAxisItem: Encodable, YAxisItem: Encodable { }
extension Edges: AdditiveArithmetic where XAxisItem: AdditiveArithmetic, YAxisItem: AdditiveArithmetic { }

#endif
