//
//  DataSourceSnapshot.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(Foundation)

import Foundation

public struct SectionDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> {

  var sections: ContiguousArray<Section<SectionIdentifierType, ItemIdentifierType>> = []

  public var numberOfSections: Int {
    sections.count
  }

  public func numberOfItems(inSection section: Int) -> Int {
    sections[section].items.count
  }

  public func sectionIdentifier(for index: Int) -> SectionIdentifierType {
    sections[index].identifier
  }

  public func itemIdentifier(for indexPath: IndexPath) -> ItemIdentifierType {
    sections[indexPath.section].items[indexPath.item].identifier
  }

  private mutating func appendItems(_ itemIdentifiers: [ItemIdentifierType], to section: Int) {
    sections[section].items.append(contentsOf: itemIdentifiers.lazy.map(Item.init))
  }

  public mutating func appendItems(_ itemIdentifiers: [ItemIdentifierType]) {
    guard !sections.isEmpty else {
      fatalError("There are currently no sections.")
    }
    appendItems(itemIdentifiers, to: sections.index(before: sections.endIndex))
  }

  public mutating func appendSection(_ sectionIdentifier: SectionIdentifierType, items itemIdentifiers: [ItemIdentifierType]) {
    sections.append(.init(identifier: sectionIdentifier, items: itemIdentifiers.lazy.map(Item.init)))
  }

  public mutating func appendSections(_ sectionIdentifiers: [SectionIdentifierType]) {
    sections.append(contentsOf: sectionIdentifiers.lazy.map(Section.init))
  }
}

extension SectionDataSourceSnapshot where SectionIdentifierType: Equatable {

  public func index(of sectionIdentifier: SectionIdentifierType) -> Int? {
    sections.firstIndex { $0.identifier == sectionIdentifier }
  }

  public mutating func appendItems(_ itemIdentifiers: [ItemIdentifierType], toSection sectionIdentifier: SectionIdentifierType?) {
    if let sectionIdentifier = sectionIdentifier {
      guard let index = index(of: sectionIdentifier) else {
        fatalError("Section \(sectionIdentifier) is not found.")
      }
      appendItems(itemIdentifiers, to: index)
    } else {
      appendItems(itemIdentifiers)
    }
  }

  @discardableResult
  private mutating func removeSection(_ sectionIdentifier: SectionIdentifierType) -> Section<SectionIdentifierType, ItemIdentifierType>? {
    guard let index = index(of: sectionIdentifier) else {
      return nil
    }
    return sections.remove(at: index)
  }

  public mutating func deleteSections(_ sectionIdentifiers: [SectionIdentifierType]) {
    for sectionIdentifier in sectionIdentifiers {
      removeSection(sectionIdentifier)
    }
  }
}

extension SectionDataSourceSnapshot where SectionIdentifierType: Hashable {

  public func index(of sectionIdentifier: SectionIdentifierType) -> Int? {
    sections.firstIndex { $0.identifier ==== sectionIdentifier }
  }

  public mutating func appendItems(_ itemIdentifiers: [ItemIdentifierType], toSection sectionIdentifier: SectionIdentifierType?) {
    if let sectionIdentifier = sectionIdentifier {
      guard let index = index(of: sectionIdentifier) else {
        fatalError("Section \(sectionIdentifier) is not found.")
      }
      appendItems(itemIdentifiers, to: index)
    } else {
      appendItems(itemIdentifiers)
    }
  }

  @discardableResult
  private mutating func removeSection(_ sectionIdentifier: SectionIdentifierType) -> Section<SectionIdentifierType, ItemIdentifierType>? {
    guard let index = index(of: sectionIdentifier) else {
      return nil
    }
    return sections.remove(at: index)
  }

  public mutating func deleteSections(_ sectionIdentifiers: [SectionIdentifierType]) {
    for sectionIdentifier in sectionIdentifiers {
      removeSection(sectionIdentifier)
    }
  }
}

#endif
