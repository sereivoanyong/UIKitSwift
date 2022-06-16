//
//  NumberTextField.swift
//
//  Created by Sereivoan Yong on 5/30/21.
//

#if os(iOS)

import UIKit

public typealias DecimalTextField = NumberTextField<Decimal> // Formatted
public typealias DoubleTextField = NumberTextField<Double> // Formatted
public typealias FloatTextField = NumberTextField<Float> // Formatted
public typealias IntTextField = NumberTextField<Int> // Lossless

open class NumberTextField<Value: _ObjectiveCBridgeable & Comparable>: TextField, UITextFieldDelegate where Value._ObjectiveCType: NSNumber {

  // Not called when the `value` is changed programmatically.
  public static var valueDidChangeNotification: Notification.Name {
    Notification.Name("NumberTextFieldValueDidChangeNotification")
  }

  open override var delegate: UITextFieldDelegate? {
    get { super.delegate }
    set {
      assert(newValue is Self, "`textField(_:shouldChangeCharactersIn:replacementString:)`")
      super.delegate = newValue
    }
  }

  open var transformer: NumberTransformer<Value>!

  open var minimumValue: Value? {
    didSet {
      if let minimumValue = minimumValue, let value = value, value < minimumValue {
        self.value = minimumValue
      }
    }
  }

  open var maximumValue: Value? {
    didSet {
      if let maximumValue = maximumValue, let value = value, value > maximumValue {
        self.value = maximumValue
      }
    }
  }

  private var _value: Value?
  open var value: Value? {
    get { _value }
    set { setValue(newValue) }
  }

  open override var text: String? {
    get { super.text }
    set(newText) { setText(newText)}
  }

  // MARK: Init

  public override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    commonInit()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: Self.textDidChangeNotification, object: self)
    keyboardType = Value.self is LosslessStringConvertible.Type ? .numberPad : .decimalPad
    delegate = self
  }

  // MARK: Transform

  open func text(from value: Value) -> String? {
    assert(transformer != nil, "`transformer` must be set.")
    return transformer.string(from: value)
  }

  open func value(from text: String) -> Value? {
    assert(transformer != nil, "`transformer` must be set.")
    return transformer.number(from: text)
  }

  func setValue(_ newValue: Value?, sendValueChangedActions: Bool = false) {
    if let newValue = newValue, let newText = text(from: newValue) {
      if let newClampedValue = clampedValue(newValue) {
        if let newClampedText = text(from: newValue) {
          _value = newClampedValue
          super.text = newClampedText
        } else {
          _value = nil
          super.text = nil
        }
      } else {
        _value = newValue
        super.text = newText
      }
    } else {
      _value = nil
      super.text = nil
    }
    if sendValueChangedActions {
      sendActions(for: .valueChanged)
      NotificationCenter.default.post(name: Self.valueDidChangeNotification, object: self)
    }
  }

  func setText(_ newText: String?, sendValueChangedActions: Bool = false) {
    if let newText = newText, let newValue = value(from: newText) {
      if let newClampedValue = clampedValue(newValue) {
        if let newClampedText = text(from: newValue) {
          _value = newClampedValue
          super.text = newClampedText
        } else {
          _value = nil
          super.text = nil
        }
      } else {
        _value = newValue
        super.text = newText
      }
    } else {
      _value = nil
      super.text = nil
    }
    if sendValueChangedActions {
      sendActions(for: .valueChanged)
      NotificationCenter.default.post(name: Self.valueDidChangeNotification, object: self)
    }
  }

  /// Returns `nil` if the value already is in valid range.
  private func clampedValue(_ value: Value) -> Value? {
    switch (minimumValue, maximumValue) {
    case (.some(let minimumValue), .some(let maximumValue)):
      let validRange = minimumValue...maximumValue
      return validRange ~= value ? nil : min(max(value, minimumValue), maximumValue)

    case (.some(let minimumValue), .none):
      return value < minimumValue ? minimumValue : nil

    case (.none, .some(let maximumValue)):
      return value > maximumValue ? maximumValue : nil

    case (.none, .none):
      return nil
    }
  }

  // MARK: UITextFieldDelegate

  /// Invoked after `textField(:shouldChangeCharactersIn:replacementString:)` returned `true`
  @objc private func textDidChange(_ notification: Notification) {
    if let text = text, !text.isEmpty {
      _value = value(from: text)!
      // It must be clamped as the function is called right after `textField(_:shouldChangeCharactersIn:replacementString:)`
      assert(clampedValue(_value!) == nil)
    } else {
      _value = nil
    }
    sendActions(for: .valueChanged)
    NotificationCenter.default.post(name: Self.valueDidChangeNotification, object: self)
  }

  @objc open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString: String) -> Bool {
    assert(textField === self)
    let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: replacementString) ?? replacementString
    if newText.isEmpty {
      // `textDidEndEditing(_:)` will be called and `value` will be set to nil
      return true
    }
    if let newValue = value(from: newText) {
      if let newClampedValue = clampedValue(newValue), let newClampedText = text(from: newClampedValue) {
        _value = newClampedValue
        super.text = newClampedText
        sendActions(for: .valueChanged)
        NotificationCenter.default.post(name: Self.valueDidChangeNotification, object: self)
        return false
      }
      // `textDidEndEditing(_:)` will be called and `value` will be set to a valid one
      return true
    }
    return false
  }
}

extension NumberTextField {

  public convenience init(formatter: NumberFormatter, value: Value? = nil, placeholder: String? = nil, font: UIFont? = nil, textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil) {
    self.init()
    self.font = font
    self.textAlignment = textAlignment
    if #available(iOS 13.0, *) {
      self.textColor = textColor ?? .label
    } else {
      self.textColor = textColor
    }
    self.placeholder = placeholder
    self.transformer = .formatted(formatter)
    self.value = value
  }

  public convenience init(value: Value? = nil, placeholder: String? = nil, font: UIFont? = nil, textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil) where Value: LosslessStringConvertible {
    self.init()
    self.font = font
    self.textAlignment = textAlignment
    if #available(iOS 13.0, *) {
      self.textColor = textColor ?? .label
    } else {
      self.textColor = textColor
    }
    self.placeholder = placeholder
    self.transformer = .default
    self.value = value
  }
}

#endif
