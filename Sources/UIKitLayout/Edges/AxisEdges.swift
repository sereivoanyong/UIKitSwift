//
//  AxisEdges.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

// MARK: Directional X Axis Edges

public protocol DirectionalXAxisEdgesProtocol {

  associatedtype DirectionalXAxisItem
  var leading: DirectionalXAxisItem { get set }
  var trailing: DirectionalXAxisItem { get set }
}

public struct DirectionalXAxisEdges<DirectionalXAxisItem>: DirectionalXAxisEdgesProtocol {

  public var leading, trailing: DirectionalXAxisItem

  public init(leading: DirectionalXAxisItem, trailing: DirectionalXAxisItem) {
    self.leading = leading
    self.trailing = trailing
  }
}

extension DirectionalXAxisEdges: Equatable where DirectionalXAxisItem: Equatable { }
extension DirectionalXAxisEdges: Hashable where DirectionalXAxisItem: Hashable { }
extension DirectionalXAxisEdges: Decodable where DirectionalXAxisItem: Decodable { }
extension DirectionalXAxisEdges: Encodable where DirectionalXAxisItem: Encodable { }

// MARK: X Axis Edges

public protocol XAxisEdgesProtocol {

  associatedtype XAxisItem
  var left: XAxisItem { get set }
  var right: XAxisItem { get set }
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

// MARK: Y Axis Edges

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

#endif
