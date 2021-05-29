//
//  ItemDataSourceSnapshot.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public struct ItemDataSourceSnapshot<ItemIdentifierType> {

  var items: ContiguousArray<Item<ItemIdentifierType>>

  public init(_ itemIdentifiers: [ItemIdentifierType] = []) {
    self.items = ContiguousArray(itemIdentifiers.lazy.map(Item.init))
  }

  public var numberOfItems: Int {
    items.count
  }

  public func itemIdentifier(for index: Int) -> ItemIdentifierType {
    items[index].identifier
  }

  public mutating func appendItems(_ itemIdentifiers: [ItemIdentifierType]) {
    items.append(contentsOf: itemIdentifiers.lazy.map(Item.init))
  }
}

extension ItemDataSourceSnapshot where ItemIdentifierType: Equatable {

  public func index(of itemIdentifier: ItemIdentifierType) -> Int? {
    items.firstIndex { $0.identifier == itemIdentifier }
  }

  @discardableResult
  private mutating func removeItem(_ itemIdentifier: ItemIdentifierType) -> Item<ItemIdentifierType>? {
    guard let index = index(of: itemIdentifier) else {
      return nil
    }
    return items.remove(at: index)
  }

  public mutating func deleteItems(_ itemIdentifiers: [ItemIdentifierType]) {
    for itemIdentifier in itemIdentifiers {
      removeItem(itemIdentifier)
    }
  }
}

extension ItemDataSourceSnapshot where ItemIdentifierType: Hashable {

  public func index(of itemIdentifier: ItemIdentifierType) -> Int? {
    items.firstIndex { $0.identifier ==== itemIdentifier }
  }

  @discardableResult
  private mutating func removeItem(_ itemIdentifier: ItemIdentifierType) -> Item<ItemIdentifierType>? {
    guard let index = index(of: itemIdentifier) else {
      return nil
    }
    return items.remove(at: index)
  }

  public mutating func deleteItems(_ itemIdentifiers: [ItemIdentifierType]) {
    for itemIdentifier in itemIdentifiers {
      removeItem(itemIdentifier)
    }
  }
}

#endif
