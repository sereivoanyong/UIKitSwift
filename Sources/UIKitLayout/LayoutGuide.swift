//
//  LayoutGuide.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

public protocol LayoutGuide: AnyObject {

  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var leftAnchor: NSLayoutXAxisAnchor { get }
  var rightAnchor: NSLayoutXAxisAnchor { get }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }
  var widthAnchor: NSLayoutDimension { get }
  var heightAnchor: NSLayoutDimension { get }
  var centerXAnchor: NSLayoutXAxisAnchor { get }
  var centerYAnchor: NSLayoutYAxisAnchor { get }

  var superLayoutGuide: LayoutGuide? { get }
}

extension UIView: LayoutGuide {

  public var superLayoutGuide: LayoutGuide? {
    superview
  }
}

extension UILayoutGuide: LayoutGuide {

  public var superLayoutGuide: LayoutGuide? {
    owningView
  }
}

#endif
