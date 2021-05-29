//
//  Item.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

struct Item<ItemIdentifierType> {

  let identifier: ItemIdentifierType
}

extension Item: Equatable where ItemIdentifierType: Equatable { }

extension Item: Hashable where ItemIdentifierType: Hashable { }

#endif
