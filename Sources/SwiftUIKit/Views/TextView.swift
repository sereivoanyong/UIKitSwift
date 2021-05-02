//
//  TextView.swift
//
//  Created by Sereivoan Yong on 5/2/21.
//

#if os(iOS)

import UIKit

// Inspired by https://github.com/devxoul/UITextView-Placeholder

@IBDesignable
open class TextView: UITextView {

  private var needsUpdateFont: Bool = false
  private var isPlaceholderTextViewLoaded: Bool = false
  private let keyPathsToObserve: [String] = [
    "attributedText", "bounds", "font", "frame", "text", "textAlignment", "textContainerInset",
    "textContainer.layoutManager.usesFontLeading", "textContainer.lineFragmentPadding", "textContainer.exclusionPaths"
  ]

  public static let defaultPlaceholderColor: UIColor = {
    if #available(iOS 13.0, *) {
      return .placeholderText
    } else {
      let textField = UITextField()
      textField.placeholder = " "
      return textField.attributedPlaceholder?.attributes(at: 0, effectiveRange: nil)[.foregroundColor] as? UIColor ?? UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
  }()

  lazy open private(set) var placeholderTextView: UITextView = {
    isPlaceholderTextViewLoaded = true
    let originalText = attributedText
    text = " " // lazily set font of `UITextView`.
    attributedText = originalText

    let textView = UITextView(frame: bounds)
    textView.backgroundColor = .clear
    textView.font = font
    textView.textAlignment = textAlignment
    textView.textColor = type(of: self).defaultPlaceholderColor
    textView.isUserInteractionEnabled = false
    textView.isAccessibilityElement = false
    textView.showsHorizontalScrollIndicator = false
    textView.showsVerticalScrollIndicator = false
    textView.textContainerInset = textContainerInset
    textView.textContainer.exclusionPaths = textContainer.exclusionPaths
    textView.textContainer.lineFragmentPadding = textContainer.lineFragmentPadding
    textView.textContainer.layoutManager!.usesFontLeading = textContainer.layoutManager!.usesFontLeading
    NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceholderTextView), name: UITextView.textDidChangeNotification, object: self)

    for keyPath in keyPathsToObserve {
      addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
    }
    return textView
  }()

  @IBInspectable
  final public var placeholder: String? {
    get { return placeholderTextView.text }
    set { placeholderTextView.text = newValue; updatePlaceholderTextView() }
  }

  open var attributedPlaceholder: NSAttributedString? {
    get { return placeholderTextView.attributedText }
    set { placeholderTextView.attributedText = newValue; updatePlaceholderTextView() }
  }

  @IBInspectable
  final public var placeholderColor: UIColor? {
    get { return placeholderTextView.textColor }
    set { placeholderTextView.textColor = newValue }
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    if isPlaceholderTextViewLoaded {
      for keyPath in keyPathsToObserve {
        removeObserver(self, forKeyPath: keyPath, context: nil)
      }
    }
  }

  open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "font" {
      needsUpdateFont = change?[.newKey] != nil
    }
    updatePlaceholderTextView()
  }

  @objc private func updatePlaceholderTextView() {
    if !text.isEmpty {
      placeholderTextView.removeFromSuperview()
    } else {
      insertSubview(placeholderTextView, at: 0)
    }

    if needsUpdateFont {
      placeholderTextView.font = font
      needsUpdateFont = false
    }
    if placeholderTextView.attributedText.length == 0 {
      placeholderTextView.textAlignment = textAlignment
    }
    placeholderTextView.textContainerInset = textContainerInset
    placeholderTextView.textContainer.layoutManager!.usesFontLeading = textContainer.layoutManager!.usesFontLeading
    placeholderTextView.textContainer.exclusionPaths = textContainer.exclusionPaths
    placeholderTextView.textContainer.lineFragmentPadding = textContainer.lineFragmentPadding
    placeholderTextView.frame = bounds
  }
}

#endif
