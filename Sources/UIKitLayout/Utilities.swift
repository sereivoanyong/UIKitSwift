//
//  Utilities.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

// MARK: Directional Edges

public typealias DirectionalEdgeInsets = DirectionalEdges<CGFloat, CGFloat>

extension DirectionalEdgesProtocol where XAxisItem == NSLayoutConstraint, YAxisItem == NSLayoutConstraint {

  public var constants: DirectionalEdgeInsets {
    get { return map { $0.constant } }
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
    get { return map { $0.constant } }
    set { set(newValue, at: \.constant) }
  }
}

extension UIEdgeInsets: EdgesProtocol { }
extension UIEdgeInsets: AdditiveArithmetic { }

#endif
