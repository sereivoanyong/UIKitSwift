//
//  DateTextField.swift
//
//  Created by Sereivoan Yong on 5/30/21.
//

#if os(iOS)

import UIKit

open class DateTextField: DropdownTextField {

  // Not called when the `date` is changed programmatically.
  public static let dateDidChangeNotification: Notification.Name = Notification.Name("DateTextFieldDateDidChangeNotification")

  open class var datePickerClass: UIDatePicker.Type {
    UIDatePicker.self
  }

  private let inputViewWrapperView: UIView
  lazy private var _dateTransformer: DateTransformer = .default
  private var _date: Date?

  /// The date picker managed by the text field and used for custom input view.
  ///
  /// Its `date` must not be changed directly.
  public let datePicker: UIDatePicker = {
    let datePicker = datePickerClass.init()
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    }
    return datePicker
  }()

  /// The date transformer used by the text field.
  ///
  /// Changing this causes `text` to change as well if `date` is not nil.
  open var dateTransformer: DateTransformer! {
    get { _dateTransformer }
    set(newDateTransformer) {
      _dateTransformer = newDateTransformer ?? .default
      super.text = date.map(_dateTransformer.string(from:))
    }
  }

  /// The date, the representable text of which is displayed by the text field.
  ///
  /// If the value is nil, it will be set to `Date()` in `becomeFirstResponder()`
  open var date: Date? {
    get { _date }
    set(newDate) {
      if let newDate = newDate {
        let newText = dateTransformer.string(from: newDate)
        setDate(newDate, text: newText, updatePicker: true, sendValueChangedActions: false)
      } else {
        setDate(nil, text: nil, updatePicker: true, sendValueChangedActions: false)
      }
    }
  }

  /// The date-representable text that the text field displays.
  ///
  /// The setting value is treated as `nil` if it is not date-representable (`nil` when converted by the `dateFormatter`).
  /// The value (if non-nil) is guaranteed to have a date representation.
  open override var text: String? {
    get { super.text }
    set(newText) {
      if let newText = newText, let newDate = dateTransformer.date(from: newText) {
        setDate(newDate, text: newText, updatePicker: true, sendValueChangedActions: false)
      } else {
        setDate(nil, text: nil, updatePicker: true, sendValueChangedActions: false)
      }
    }
  }

  // MARK: Initializer

  public override init(frame: CGRect = .zero) {
    inputViewWrapperView = Self.wrapperView(inputView: datePicker)
    super.init(frame: frame)
    commonInit()
  }

  public required init?(coder: NSCoder) {
    inputViewWrapperView = Self.wrapperView(inputView: datePicker)
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    datePicker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
  }

  // MARK: Private

  @objc private func dateDidChange(_ datePicker: UIDatePicker) {
    let newDate = datePicker.date
    let newText = dateTransformer.string(from: newDate)
    setDate(newDate, text: newText, updatePicker: false, sendValueChangedActions: true)
  }

  private func setDate(_ date: Date?, text: String?, updatePicker: Bool, sendValueChangedActions: Bool) {
    willChangeValue(forKey: "date")
    willChangeValue(for: \.text)
    if date != _date {
      _date = date
      super.text = text
      if updatePicker, let date = date {
        datePicker.date = date
      }
      if sendValueChangedActions {
        sendActions(for: .valueChanged)
        NotificationCenter.default.post(name: Self.dateDidChangeNotification, object: self)
      }
    }
    didChangeValue(forKey: "date")
    didChangeValue(for: \.text)
  }

  // MARK: Public

  open override var inputView: UIView? {
    get { super.inputView ?? inputViewWrapperView }
    set { super.inputView = newValue }
  }

  @discardableResult
  open override func becomeFirstResponder() -> Bool {
    let become = super.becomeFirstResponder()
    if become {
      if date == nil {
        date = Date()
      }
    }
    return become
  }

  open override func clear() {
    date = nil
  }
}

extension DateTextField {

  public convenience init(formatter: DateFormatter, date: Date? = nil, placeholder: String? = nil, font: UIFont? = nil, textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil) {
    self.init()
    self.font = font
    self.textAlignment = textAlignment
    // On iOS 13, default text color is `.label`. When Set to nil, it becomes `.black`
    if #available(iOS 13.0, *) {
      self.textColor = textColor ?? .label
    } else {
      self.textColor = textColor
    }
    self.dateTransformer = .formatted(formatter)
    self.date = date
    self.placeholder = placeholder
  }
}

#endif
