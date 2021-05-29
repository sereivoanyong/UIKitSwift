//
//  Section.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

struct Section<SectionIdentifierType, ItemIdentifierType> {

  let identifier: SectionIdentifierType
  var items: ContiguousArray<Item<ItemIdentifierType>>

  init(identifier: SectionIdentifierType) {
    self.identifier = identifier
    self.items = []
  }

  init<S: Sequence>(identifier: SectionIdentifierType, items: S) where S.Element == Item<ItemIdentifierType> {
    self.identifier = identifier
    self.items = ContiguousArray(items)
  }
}

extension Section: Equatable where SectionIdentifierType: Equatable, ItemIdentifierType: Equatable { }

extension Section: Hashable where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable { }

#endif
