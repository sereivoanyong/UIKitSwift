//
//  StackView.swift
//
//  Created by Sereivoan Yong on 3/2/21.
//

#if os(iOS)

import UIKit

extension UIStackView {

  // Raw value is important. Do not change.
  public enum SeparatorInsetReference: Int {

    case fromEdges = 0

    @available(iOS 11.0, *)
    case fromSafeArea = 1

    case fromLayoutMargins = 2
  }
}

@IBDesignable
open class StackView: UIStackView {

  open private(set) var separatorViews: [UIView] = []

  open var separatorViewProvider: () -> UIView = {
    let separatorView = UIView()
    if #available(iOS 13.0, *) {
      separatorView.backgroundColor = .separator
    } else {
      separatorView.backgroundColor = UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.29)
    }
    return separatorView
  }

  @IBInspectable open var separatorThickness: CGFloat = 0

  open var separatorInset: UIEdgeInsets = .zero

  open var separatorInsetReference: SeparatorInsetReference = .fromEdges

  open override func layoutSubviews() {
    super.layoutSubviews()

    layoutSeparatorViews()
  }

  private func layoutSeparatorViews() {
    let arrangedSubviews = self.arrangedSubviews
    guard arrangedSubviews.count > 1 else {
      if !separatorViews.isEmpty {
        for separatorView in separatorViews {
          separatorView.removeFromSuperview()
        }
        separatorViews.removeAll()
      }
      return
    }

    let countToAdd = arrangedSubviews.count - 1 - separatorViews.count
    if countToAdd > 0 {
      for _ in 0..<countToAdd {
        let separatorView = separatorViewProvider()
        addSubview(separatorView)
        separatorViews.append(separatorView)
      }
    } else if countToAdd < 0 {
      let countToRemove = -countToAdd
      for separatorView in separatorViews[(separatorViews.count - 1 - countToRemove)...] {
        separatorView.removeFromSuperview()
      }
      separatorViews.removeLast(countToRemove)
    }

    precondition(separatorViews.count == arrangedSubviews.count - 1)

    var inset = separatorInset
    let referenceInset: UIEdgeInsets
    switch separatorInsetReference {
    case .fromEdges:
      referenceInset = .zero
    case .fromSafeArea:
      guard #available(iOS 11.0, *) else {
        fatalError()
      }
      referenceInset = safeAreaInsets
    case .fromLayoutMargins:
      referenceInset = layoutMargins
    }
    inset = UIEdgeInsets(top: inset.top + referenceInset.top, left: inset.left + referenceInset.left, bottom: inset.bottom + referenceInset.bottom, right: inset.right + referenceInset.right)

    let thickness = separatorThickness > 0 ? separatorThickness : (1 / traitCollection.displayScale)

    let frameProvider: (UIView, UIView) -> CGRect
    switch axis {
    case .vertical:
      frameProvider = { [unowned self] topView, bottomView in
        let y = topView.frame.maxY + ceil((bottomView.frame.minY - topView.frame.maxY + thickness) / 2, by: traitCollection.displayScale)
        return CGRect(x: layoutMargins.left, y: y, width: bounds.width - layoutMargins.left - layoutMargins.right, height: thickness)
      }
    default:
      frameProvider = { [unowned self] leftView, rightView in
        let x = leftView.frame.maxX + ceil((rightView.frame.minX - leftView.frame.maxX + thickness) / 2, by: traitCollection.displayScale)
        return CGRect(x: x, y: layoutMargins.top, width: thickness, height: bounds.height - layoutMargins.top - layoutMargins.bottom)
      }
    }

    for (index, arrangedSubview) in arrangedSubviews.dropLast().enumerated() {
      let separatorView = separatorViews[index]
      separatorView.frame = frameProvider(arrangedSubview, arrangedSubviews[index + 1])
    }
  }
}

extension StackView {

  @IBInspectable final public var separatorInsetReferenceRaw: Int {
    get { separatorInsetReference.rawValue }
    set { separatorInsetReference = SeparatorInsetReference(rawValue: newValue) ?? .fromEdges }
  }
}

private func ceil(_ x: CGFloat, by scale: CGFloat) -> CGFloat {
  return ceil(x * scale) / scale
}

#endif
