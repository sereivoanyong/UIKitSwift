//
//  SeparatorView.swift
//
//  Created by Sereivoan Yong on 3/2/21.
//

#if os(iOS)

import UIKit

@IBDesignable
open class SeparatorView: UIView {

  public static var backgroundColor: UIColor?

  // Axis is not marked as frozen. Instead, `isVertical` is widely used.
  open var axis: NSLayoutConstraint.Axis = .horizontal

  // Set to nil to use default.
  open override var backgroundColor: UIColor! {
    get { super.backgroundColor }
    set { super.backgroundColor = newValue ?? SeparatorView.defaultBackgroundColor() }
  }

  // 0 means pixel (1 / display scale)
  @IBInspectable
  open var thickness: CGFloat = 0 {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  public override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    #if !TARGET_INTERFACE_BUILDER
    commonInit()
    #endif
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    // Check if values are not set by interface builder
    if backgroundColor == nil {
      backgroundColor = SeparatorView.defaultBackgroundColor()
    }
    if contentCompressionResistancePriority(for: .horizontal) == .defaultHigh {
      setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
    }
    if contentCompressionResistancePriority(for: .vertical) == .defaultHigh {
      setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
    }
  }

  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    commonInit()
  }

  open override var intrinsicContentSize: CGSize {
    if isVertical {
      return CGSize(width: thickness > 0 ? thickness : (1 / traitCollection.displayScale), height: UIView.noIntrinsicMetric)
    } else {
      return CGSize(width: UIView.noIntrinsicMetric, height: thickness > 0 ? thickness : (1 / traitCollection.displayScale))
    }
  }

  private static func defaultBackgroundColor() -> UIColor {
    if let backgroundColor = SeparatorView.backgroundColor {
      return backgroundColor
    } else {
      if #available(iOS 13.0, *) {
        return .separator
      } else {
        return UIColor(red: 60/255.0, green: 60/255.0, blue: 67/255.0, alpha: 0.29)
      }
    }
  }
}

extension SeparatorView {

  @IBInspectable
  final public var isVertical: Bool {
    get { axis == .vertical }
    set { axis = newValue ? .vertical : .horizontal }
  }
}

#endif
