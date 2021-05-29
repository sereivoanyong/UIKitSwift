//
//  NSLayoutDimension+ConstraintProvider.swift
//
//  Created by Sereivoan Yong on 5/29/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

extension NSLayoutDimension {

  public struct Attributes {

    public let dimension: NSLayoutDimension
    public let multiplier: CGFloat
  }
}

extension NSLayoutDimension {

  // MARK: Provider using another dimension

  @inlinable
  public static func equal(dimension: NSLayoutDimension, attributes: Attributes) -> NSLayoutConstraint {
    dimension.constraint(equalTo: attributes.dimension, multiplier: attributes.multiplier)
  }

  @inlinable
  public static func greaterThanOrEqual(dimension: NSLayoutDimension, attributes: Attributes) -> NSLayoutConstraint {
    dimension.constraint(greaterThanOrEqualTo: attributes.dimension, multiplier: attributes.multiplier)
  }

  @inlinable
  public static func lessThanOrEqual(dimension: NSLayoutDimension, attributes: Attributes) -> NSLayoutConstraint {
    dimension.constraint(lessThanOrEqualTo: attributes.dimension, multiplier: attributes.multiplier)
  }

  // MARK: Provider using constant

  @inlinable
  public static func equal(dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    dimension.constraint(equalToConstant: constant)
  }

  @inlinable
  public static func greaterThanOrEqual(dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    dimension.constraint(greaterThanOrEqualToConstant: constant)
  }

  @inlinable
  public static func lessThanOrEqual(dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    dimension.constraint(lessThanOrEqualToConstant: constant)
  }

  // MARK: Operator provider using another dimension

  /// `anchor == otherAnchor`
  /// - returns: `anchor.constraint(equalTo: otherAnchor)`
  public static func == (dimension: NSLayoutDimension, otherDimension: NSLayoutDimension) -> NSLayoutConstraint {
    equal(dimension: dimension, attributes: Attributes(dimension: otherDimension, multiplier: 1))
  }

  /// `anchor >= otherAnchor`
  /// - returns: `anchor.constraint(greaterThanOrEqualTo: otherAnchor)`
  public static func >= (dimension: NSLayoutDimension, otherDimension: NSLayoutDimension) -> NSLayoutConstraint {
    greaterThanOrEqual(dimension: dimension, attributes: Attributes(dimension: otherDimension, multiplier: 1))
  }

  /// `anchor <= otherAnchor`
  /// - returns: `anchor.constraint(lessThanOrEqualTo: otherAnchor)`
  public static func <= (dimension: NSLayoutDimension, otherDimension: NSLayoutDimension) -> NSLayoutConstraint {
    lessThanOrEqual(dimension: dimension, attributes: Attributes(dimension: otherDimension, multiplier: 1))
  }

  /// `anchor == otherAnchor * multiplier`
  /// - returns: `anchor.constraint(equalTo: otherAnchor, multiplier: multiplier)`
  @inlinable
  public static func == (dimension: NSLayoutDimension, attributes: Attributes) -> NSLayoutConstraint {
    equal(dimension: dimension, attributes: attributes)
  }

  /// `anchor >= otherAnchor * multiplier`
  /// - returns: `anchor.constraint(greaterThanOrEqualTo: otherAnchor, multiplier: multiplier)`
  @inlinable
  public static func >= (dimension: NSLayoutDimension, attributes: Attributes) -> NSLayoutConstraint {
    greaterThanOrEqual(dimension: dimension, attributes: attributes)
  }

  /// `anchor <= otherAnchor * multiplier`
  /// - returns: `anchor.constraint(lessThanOrEqualTo: otherAnchor, multiplier: multiplier)`
  @inlinable
  public static func <= (dimension: NSLayoutDimension, attributes: Attributes) -> NSLayoutConstraint {
    lessThanOrEqual(dimension: dimension, attributes: attributes)
  }

  // MARK: Operator provider using constant

  /// `anchor == constant`
  /// - returns: `anchor.constraint(equalToConstant: constant)`
  @inlinable
  public static func == (dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    equal(dimension: dimension, constant: constant)
  }

  /// `anchor >= constant`
  /// - returns: `anchor.constraint(greaterThanOrEqualToConstant: constant)`
  @inlinable
  public static func >= (dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    greaterThanOrEqual(dimension: dimension, constant: constant)
  }

  /// `anchor <= constant`
  /// - returns: `anchor.constraint(lessThanOrEqualToConstant: constant)`
  @inlinable
  public static func <= (dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    lessThanOrEqual(dimension: dimension, constant: constant)
  }

  public static func * (dimension: NSLayoutDimension, multiplier: CGFloat) -> Attributes {
    Attributes(dimension: dimension, multiplier: multiplier)
  }
}

#endif
