//
//  CollectionViewDataSource.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

open class CollectionViewDataSource<SectionIdentifierType, ItemIdentifierType>: NSObject, UICollectionViewDataSource {

  public let core: SectionDataSourceCore<SectionIdentifierType, ItemIdentifierType>

  weak open private(set) var collectionView: UICollectionView?

  public init(core: SectionDataSourceCore<SectionIdentifierType, ItemIdentifierType> = .init(), collectionView: UICollectionView, cellProvider: @escaping CellProvider) {
    self.core = core
    self.collectionView = collectionView
    self.cellProvider = cellProvider
    super.init()

    collectionView.dataSource = self
  }

  open func apply(_ snapshot: SectionDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>) {
    core.apply(snapshot, reloadable: collectionView) { collectionView in
      collectionView.reloadData()
    }
  }

  open func snapshot() -> SectionDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType> {
    core.snapshot()
  }

  // MARK: UICollectionViewDataSource

  open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    core.numberOfItems(inSection: section)
  }

  public typealias CellProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> UICollectionViewCell?
  public let cellProvider: CellProvider
  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    cellProvider(collectionView, indexPath, core.itemIdentifier(for: indexPath))!
  }

  open func numberOfSections(in collectionView: UICollectionView) -> Int {
    core.numberOfSections
  }

  public typealias SupplementaryViewProvider = (UICollectionView, String, IndexPath, SectionIdentifierType) -> UICollectionReusableView?
  open var supplementaryViewProvider: SupplementaryViewProvider?
  open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    supplementaryViewProvider!(collectionView, kind, indexPath, core.sectionIdentifier(forSection: indexPath.section))!
  }

  public typealias CanMoveProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  open var canMoveProvider: CanMoveProvider?
  open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    canMoveProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? false
  }

  public typealias MoveHandler = (UICollectionView, IndexPath, ItemIdentifierType, IndexPath, ItemIdentifierType) -> Void
  open var moveHandler: MoveHandler?
  open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    moveHandler?(collectionView, sourceIndexPath, core.itemIdentifier(for: sourceIndexPath), destinationIndexPath, core.itemIdentifier(for: destinationIndexPath))
  }

  @available(iOS 14.0, *)
  public typealias IndexTitlesProvider = (UICollectionView) -> [String]?
  private var _indexTitlesProvider: Any?
  @available(iOS 14.0, *)
  open var indexTitlesProvider: IndexTitlesProvider? {
    get { _indexTitlesProvider as? IndexTitlesProvider }
    set { _indexTitlesProvider = newValue }
  }
  @available(iOS 14.0, *)
  open func indexTitles(for collectionView: UICollectionView) -> [String]? {
    indexTitlesProvider?(collectionView)
  }

  @available(iOS 14.0, *)
  public typealias IndexPathForIndexTitleProvider = (UICollectionView, String, Int) -> IndexPath?
  private var _indexPathForIndexTitleProvider: Any?
  @available(iOS 14.0, *)
  open var indexPathForIndexTitleProvider: IndexPathForIndexTitleProvider? {
    get { _indexPathForIndexTitleProvider as? IndexPathForIndexTitleProvider }
    set { _indexPathForIndexTitleProvider = newValue }
  }
  @available(iOS 14.0, *)
  open func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
    (indexPathForIndexTitleProvider?(collectionView, title, index))!
  }
}

#endif
