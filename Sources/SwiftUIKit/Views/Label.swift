//
//  Label.swift
//
//  Created by Sereivoan Yong on 3/2/21.
//

#if os(iOS)

import UIKit

@IBDesignable
open class Label: UILabel {
  
  open var insets: UIEdgeInsets = .zero {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
    let textRect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
    let invertedInsets = UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right)
    return textRect.inset(by: invertedInsets)
  }
  
  open override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: insets))
  }
}

extension Label {
  
  @IBInspectable final public var topInset: CGFloat {
    get { insets.top }
    set { insets.top = newValue }
  }
  
  @IBInspectable final public var leftInset: CGFloat {
    get { insets.left }
    set { insets.left = newValue }
  }
  
  @IBInspectable final public var bottomInset: CGFloat {
    get { insets.bottom }
    set { insets.bottom = newValue }
  }
  
  @IBInspectable final public var rightInset: CGFloat {
    get { insets.right }
    set { insets.right = newValue }
  }
}

#endif
