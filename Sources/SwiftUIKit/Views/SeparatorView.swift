//
//  SeparatorView.swift
//
//  Created by Sereivoan Yong on 3/2/21.
//

#if os(iOS)

import UIKit

@IBDesignable
open class SeparatorView: UIView {

  open var axis: NSLayoutConstraint.Axis = .horizontal

  @IBInspectable open var thickness: CGFloat = 0 {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  public override init(frame: CGRect = .zero) {
    super.init(frame: frame)

    #if !TARGET_INTERFACE_BUILDER
    if #available(iOS 13.0, *) {
      backgroundColor = .separator
    } else {
      backgroundColor = UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.29)
    }
    #endif
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  open override var intrinsicContentSize: CGSize {
    switch axis {
    case .vertical:
      return CGSize(width: thickness > 0 ? thickness : (1 / traitCollection.displayScale), height: UIView.noIntrinsicMetric)
    default:
      return CGSize(width: UIView.noIntrinsicMetric, height: thickness > 0 ? thickness : (1 / traitCollection.displayScale))
    }
  }
}

extension SeparatorView {

  @IBInspectable final public var isVertical: Bool {
    get { axis == .vertical }
    set { axis = newValue ? .vertical : .horizontal }
  }
}

#endif
