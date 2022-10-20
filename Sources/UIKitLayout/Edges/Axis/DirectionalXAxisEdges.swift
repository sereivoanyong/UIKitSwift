//
//  DirectionalXAxisEdges.swift
//
//  Created by Sereivoan Yong on 6/4/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol DirectionalXAxisEdgesProtocol<DirectionalXAxisItem> {

  associatedtype DirectionalXAxisItem

  var leading: DirectionalXAxisItem { get set }
  var trailing: DirectionalXAxisItem { get set }
}

extension DirectionalXAxisEdgesProtocol where DirectionalXAxisItem: AdditiveArithmetic {

  public var horizontal: DirectionalXAxisItem {
    return leading + trailing
  }

  public var withoutHorizontal: Self {
    return withHorizontal(leading: .zero, trailing: .zero)
  }

  public func withHorizontal(leading: DirectionalXAxisItem, trailing: DirectionalXAxisItem) -> Self {
    var copy = self
    copy.leading = leading
    copy.trailing = trailing
    return copy
  }
}

public struct DirectionalXAxisEdges<DirectionalXAxisItem>: DirectionalXAxisEdgesProtocol {

  public var leading, trailing: DirectionalXAxisItem

  public init(leading: DirectionalXAxisItem, trailing: DirectionalXAxisItem) {
    self.leading = leading
    self.trailing = trailing
  }

  public var all: [DirectionalXAxisItem] {
    return [leading, trailing]
  }
}

extension DirectionalXAxisEdges: Equatable where DirectionalXAxisItem: Equatable { }

extension DirectionalXAxisEdges: Hashable where DirectionalXAxisItem: Hashable { }

extension DirectionalXAxisEdges: Decodable where DirectionalXAxisItem: Decodable { }

extension DirectionalXAxisEdges: Encodable where DirectionalXAxisItem: Encodable { }

extension DirectionalXAxisEdges: AdditiveArithmetic where DirectionalXAxisItem: AdditiveArithmetic {

  public static var zero: Self {
    return .init(leading: .zero, trailing: .zero)
  }

  public static func + (lhs: Self, rhs: Self) -> Self {
    return .init(leading: lhs.leading + rhs.leading, trailing: lhs.trailing + rhs.trailing)
  }

  public static func - (lhs: Self, rhs: Self) -> Self {
    return .init(leading: lhs.leading - rhs.leading, trailing: lhs.trailing - rhs.trailing)
  }
}

extension DirectionalXAxisEdges where DirectionalXAxisItem: Numeric {

  public static func * (lhs: Self, rhs: DirectionalXAxisItem) -> Self {
    return .init(leading: lhs.leading * rhs, trailing: lhs.trailing * rhs)
  }
}

#endif
