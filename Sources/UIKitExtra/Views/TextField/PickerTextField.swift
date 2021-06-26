//
//  PickerTextField.swift
//
//  Created by Sereivoan Yong on 5/30/21.
//

#if os(iOS)

import UIKit

open class PickerTextField<Item: Equatable>: DropdownTextField {

  public static var selectedItemDidChangeNotification: Notification.Name {
    Notification.Name("PickerTextField<\(Item.self)>SelectedItemDidChangeNotification")
  }

  public enum Source {

    case pickerView(UIPickerView, adapter: PickerViewAdapter<Item>)
    case presentation(handler: (Item?, @escaping (Item?) -> Void) -> UIViewController)
  }

  weak private var _presentingViewController: UIViewController?
  private var inputViewWrapperView: UIView!

  open override var inputView: UIView? {
    get { super.inputView ?? inputViewWrapperView }
    set { super.inputView = newValue }
  }

  open private(set) var source: Source?

  private var _selectedItem: Item?
  open var selectedItem: Item? {
    get { _selectedItem }
    set { select(newValue, updateSource: true, sendValueChangedActions: false) }
  }

  open var textProvider: (Item) -> String = String.init(describing:) {
    didSet {
      text = selectedItem.map(textProvider)
    }
  }

  open var changeHandler: ((Item?) -> Void)?

  private func select(_ selectedItem: Item?, updateSource: Bool, sendValueChangedActions: Bool) {
    willChangeValue(forKey: "selectedItem")
    if selectedItem != _selectedItem {
      _selectedItem = selectedItem
      text = selectedItem.map(textProvider)
      if updateSource, let source = source {
        switch source {
        case .pickerView(let pickerView, let adapter):
          if let selectedItem = selectedItem, let row = adapter.items.firstIndex(of: selectedItem) {
            pickerView.selectRow(row, inComponent: 0, animated: false)
          } else {
            assertionFailure("`Source.pickerView` requires selected item to be in `items` and not nil. Consider using table view instead")
          }

        case .presentation:
          break
        }
      }
      if sendValueChangedActions {
        sendActions(for: .valueChanged)
        NotificationCenter.default.post(name: Self.selectedItemDidChangeNotification, object: self)
        changeHandler?(selectedItem)
      }
    }
    didChangeValue(forKey: "selectedItem")
  }

  open func setSourcePickerView(_ pickerView: UIPickerView? = nil, configurationHandler: ((PickerViewAdapter<Item>) -> Void)? = nil) where Item: CaseIterable, Item.AllCases == [Item] {
    setSourcePickerView(pickerView, items: Item.allCases, configurationHandler: configurationHandler)
  }

  open func setSourcePickerView(_ pickerView: UIPickerView? = nil, items: [Item], configurationHandler: ((PickerViewAdapter<Item>) -> Void)? = nil) {
    let pickerView = pickerView ?? UIPickerView()
    let adapter = PickerViewAdapter(pickerView: pickerView, items: items)
    configurationHandler?(adapter)
    assert(adapter.selectionHandler == nil, "`selectionHandler` is managed by the textField")
    adapter.selectionHandler = { [unowned self] _, _, _, item in
      select(item, updateSource: false, sendValueChangedActions: true)
    }
    source = .pickerView(pickerView, adapter: adapter)
    inputViewWrapperView = Self.wrapperView(inputView: pickerView)
  }

  open func setSourcePresentation(handler: @escaping (Item?, @escaping (Item?) -> Void) -> UIViewController) {
    source = .presentation(handler: handler)
  }

  @discardableResult
  open override func becomeFirstResponder() -> Bool {
    let become = super.becomeFirstResponder()
    if become, let source = source {
      switch source {
      case .pickerView(let pickerView, let adapter):
        if let selectedItem = selectedItem {
          if let row = adapter.items.firstIndex(of: selectedItem), pickerView.selectedRow(inComponent: 0) != row {
            DispatchQueue.main.async {
              pickerView.selectRow(row, inComponent: 0, animated: false)
            }
          }
        } else {
          if let firstItem = adapter.items.first {
            select(firstItem, updateSource: true, sendValueChangedActions: true)
          }
        }

      case .presentation(let handler):
        defer {
          /// `becomeFirstResponder` is not reliable because it is called more than once on iOS 14 causing multiple view controllers to present
          /// So we will keep weak reference to presenting view controller & invoke the handler only if it is not nil as a workaround

          /// Resign first responder immediately. Otherwise, first responder will be restored after the presenting view controller is dismissed
          resignFirstResponder()
          if _presentingViewController == nil {
            _presentingViewController = handler(selectedItem, { [unowned self] item in
              select(item, updateSource: false, sendValueChangedActions: true)
            })
          }
        }
        /// Return `true` to take first responder from previous view
        return become
      }
    }
    return become
  }

  open override func clear() {
    selectedItem = nil
  }
}

extension PickerTextField {

  public convenience init(selectedItem: Item? = nil, placeholder: String? = nil, font: UIFont? = nil, textAlignment: NSTextAlignment = .left, textColor: UIColor? = nil) {
    self.init()
    self.font = font
    self.textAlignment = textAlignment
    self.textColor = textColor
    self.placeholder = placeholder
    self.selectedItem = selectedItem
  }
}

#endif
