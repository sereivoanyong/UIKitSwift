//
//  PickerListViewController.swift
//
//  Created by Sereivoan Yong on 3/10/22.
//

import UIKit

// TODO: search support & section/item modeling rework

@available(iOS 14.0, *)
open class PickerListViewController<Item>: CollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  public struct Section {

    public let items: [Item]
  }

  lazy open private(set) var doneButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
  lazy open private(set) var cancelButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))

  private let equalityProvider: (Item, Item) -> Bool

  open var sections: [Section] {
    didSet {
      if isCollectionViewLoaded {
        collectionView.reloadData()
      }
    }
  }

  open var selectedItem: Item?

  public var contentProvider: (Item) -> UIListContentConfiguration = { item in
    var content = UIListContentConfiguration.cell()
    content.text = "\(item)"
    return content
  } {
    didSet {
      if isCollectionViewLoaded {
        collectionView.reloadData()
      }
    }
  }

  public var selectionCancellationHandler: (() -> Void)?

  /// If this property is not nil, it'll be invoked whenever selection changes and user must tap done to save and dismiss
  public var selectionHandler: ((Item) -> Void)? {
    didSet {
      navigationItem.rightBarButtonItem = selectionHandler != nil ? doneButtonItem : nil
    }
  }

  public let doneHandler: (Item) -> Void

  public convenience init(items: [Item], doneHandler: @escaping (Item) -> Void) where Item: Identifiable {
    self.init(equalityProvider: { $0.id == $1.id }, items: items, doneHandler: doneHandler)
  }

  public convenience init(items: [Item], doneHandler: @escaping (Item) -> Void) where Item: Equatable {
    self.init(equalityProvider: ==, items: items, doneHandler: doneHandler)
  }

  private init(equalityProvider: @escaping (Item, Item) -> Bool, items: [Item], doneHandler: @escaping (Item) -> Void) {
    self.equalityProvider = equalityProvider
    self.sections = [.init(items: items)]
    self.doneHandler = doneHandler
    super.init(nibName: nil, bundle: nil)

    navigationItem.largeTitleDisplayMode = .never
  }

  @available(*, unavailable)
  public required init?(coder: NSCoder) {
    fatalError("\(#function) has not been implemented")
  }

  open override func makeCollectionViewLayout() -> UICollectionViewLayout {
    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    configuration.backgroundColor = .clear
    return UICollectionViewCompositionalLayout.list(using: configuration)
  }

  open override func collectionViewDidLoad() {
    super.collectionViewDidLoad()

    collectionView.register(PickerListCell.self, forCellWithReuseIdentifier: "\(PickerListCell.self)")

    if let selectedItem = selectedItem {
      for (sectionIndex, section) in sections.enumerated() {
        for (itemIndex, item) in section.items.enumerated() where equalityProvider(item, selectedItem) {
          DispatchQueue.main.async { [unowned collectionView] in
            collectionView.selectItem(at: IndexPath(item: itemIndex, section: sectionIndex), animated: false, scrollPosition: .centeredVertically)
          }
          return
        }
      }
    }
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
  }

  open override func willMove(toParent parent: UIViewController?) {
    if let navigationController = parent as? UINavigationController, navigationController.viewControllers.count == 1 {
      navigationItem.leftBarButtonItem = cancelButtonItem
    }
    super.willMove(toParent: parent)
  }

  @objc open func done(_ sender: Any?) {
    guard let selectedItem = selectedItem else {
      return
    }
    doneHandler(selectedItem)
    dismiss(animated: true, completion: nil)
  }

  @objc open func cancel(_ sender: UIBarButtonItem) {
    selectionCancellationHandler?()
    dismiss(animated: true, completion: nil)
  }

  @inlinable
  func item(at indexPath: IndexPath) -> Item {
    return sections[indexPath.section].items[indexPath.item]
  }

  open func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }

  open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sections[section].items.count
  }

  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PickerListCell.self)", for: indexPath) as! PickerListCell
    let item = item(at: indexPath)
    cell.contentConfiguration = contentProvider(item)
    var background = UIBackgroundConfiguration.listPlainCell()
    background.backgroundColorTransformer = UIConfigurationColorTransformer { _ in
      return .clear
    }
    cell.backgroundConfiguration = background
    return cell
  }

  open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let newSelectedItem = item(at: indexPath)
    selectedItem = newSelectedItem
    if let selectionHandler = selectionHandler {
      selectionHandler(newSelectedItem)
    } else {
      done(collectionView.cellForItem(at: indexPath))
    }
  }
}

@available(iOS 14.0, *)
final private class PickerListCell: UICollectionViewListCell {

  override var isSelected: Bool {
    didSet {
      accessories = isSelected ? [.checkmark()] : []
    }
  }
}
