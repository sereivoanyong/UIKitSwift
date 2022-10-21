//
//  DirectionalXAxisEdges.swift
//
//  Created by Sereivoan Yong on 6/4/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public protocol DirectionalXAxisEdgesProtocol<XAxisItem> {

  associatedtype XAxisItem

  var leading: XAxisItem { get set }
  var trailing: XAxisItem { get set }
}

extension DirectionalXAxisEdgesProtocol where XAxisItem: AdditiveArithmetic {

  public var horizontal: XAxisItem {
    return leading + trailing
  }

  public var withoutHorizontal: Self {
    return withHorizontal(leading: .zero, trailing: .zero)
  }

  public func withHorizontal(leading: XAxisItem, trailing: XAxisItem) -> Self {
    var copy = self
    copy.leading = leading
    copy.trailing = trailing
    return copy
  }
}

public struct DirectionalXAxisEdges<XAxisItem>: DirectionalXAxisEdgesProtocol {

  public var leading, trailing: XAxisItem

  public init(leading: XAxisItem, trailing: XAxisItem) {
    self.leading = leading
    self.trailing = trailing
  }

  public var all: [XAxisItem] {
    return [leading, trailing]
  }
}

extension DirectionalXAxisEdges: Equatable where XAxisItem: Equatable { }

extension DirectionalXAxisEdges: Hashable where XAxisItem: Hashable { }

extension DirectionalXAxisEdges: Decodable where XAxisItem: Decodable { }

extension DirectionalXAxisEdges: Encodable where XAxisItem: Encodable { }

extension DirectionalXAxisEdges: AdditiveArithmetic where XAxisItem: AdditiveArithmetic {

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

extension DirectionalXAxisEdges where XAxisItem: Numeric {

  public static func * (lhs: Self, rhs: XAxisItem) -> Self {
    return .init(leading: lhs.leading * rhs, trailing: lhs.trailing * rhs)
  }
}

#endif
