//
//  ItemDataSourceCore.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

open class ItemDataSourceCore<ItemIdentifierType> {

  private var currentSnapshot: ItemDataSourceSnapshot<ItemIdentifierType> = .init()
  private var items: ContiguousArray<Item<ItemIdentifierType>> = []

  public init() { }

  open func apply<Reloadable: AnyObject>(_ snapshot: ItemDataSourceSnapshot<ItemIdentifierType>, reloadable: Reloadable?, reloadDataHandler: (Reloadable) -> Void) {
    currentSnapshot = snapshot
    items = snapshot.items
    guard let reloadable = reloadable else {
      return
    }
    reloadDataHandler(reloadable)
  }

  open func snapshot() -> ItemDataSourceSnapshot<ItemIdentifierType> {
    currentSnapshot
  }
  
  open var numberOfItems: Int {
    items.count
  }

  open func firstIndex(for itemIdentifier: ItemIdentifierType) -> Int? where ItemIdentifierType: Equatable {
    items.firstIndex(of: Item<ItemIdentifierType>(identifier: itemIdentifier))
  }
  
  open func itemIdentifier(for index: Int) -> ItemIdentifierType {
    items[index].identifier
  }
}

#endif
