//
//  SectionDataSourceCore.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

open class SectionDataSourceCore<SectionIdentifierType, ItemIdentifierType> {

  private var currentSnapshot: SectionDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> = .init()
  private var sections: ContiguousArray<Section<SectionIdentifierType, ItemIdentifierType>> = []

  public init() { }

  open func apply<Reloadable: AnyObject>(_ snapshot: SectionDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>, reloadable: Reloadable?, reloadDataHandler: (Reloadable) -> Void) {
    currentSnapshot = snapshot
    sections = snapshot.sections
    guard let reloadable = reloadable else {
      return
    }
    reloadDataHandler(reloadable)
  }

  open func snapshot() -> SectionDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> {
    currentSnapshot
  }
  
  open var numberOfSections: Int {
    sections.count
  }
  
  open func numberOfItems(inSection section: Int) -> Int {
    sections[section].items.count
  }
  
  open func sectionIdentifier(forSection section: Int) -> SectionIdentifierType {
    sections[section].identifier
  }
  
  open func itemIdentifier(for indexPath: IndexPath) -> ItemIdentifierType {
    sections[indexPath.section].items[indexPath.item].identifier
  }
}

#endif
