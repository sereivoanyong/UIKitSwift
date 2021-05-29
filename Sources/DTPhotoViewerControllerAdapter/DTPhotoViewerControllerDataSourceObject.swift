//
//  DTPhotoViewerControllerDataSourceObject.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

import UIKit
import UIKitAdapter
import DTPhotoViewerController

open class DTPhotoViewerControllerDataSourceObject<ItemIdentifierType>: NSObject, DTPhotoViewerControllerDataSource {

  public let core: ItemDataSourceCore<ItemIdentifierType>

  weak open private(set) var photoViewerController: DTPhotoViewerController?

  public init(core: ItemDataSourceCore<ItemIdentifierType> = .init(), photoViewerController: DTPhotoViewerController, photoConfigurationHandler: @escaping PhotoConfigurationHandler) {
    self.core = core
    self.photoViewerController = photoViewerController
    self.photoConfigurationHandler = photoConfigurationHandler
    super.init()

    photoViewerController.dataSource = self
  }

  open func apply(_ snapshot: ItemDataSourceSnapshot<ItemIdentifierType>) {
    core.apply(snapshot, reloadable: photoViewerController) { photoViewerController in
      photoViewerController.reloadData()
    }
  }

  open func snapshot() -> ItemDataSourceSnapshot<ItemIdentifierType> {
    core.snapshot()
  }

  // MARK: DTPhotoViewerControllerDataSource

  open func numberOfItems(in photoViewerController: DTPhotoViewerController) -> Int {
    core.numberOfItems
  }

  public typealias PhotoConfigurationHandler = (DTPhotoViewerController, Int, ItemIdentifierType, UIImageView) -> Void
  public let photoConfigurationHandler: PhotoConfigurationHandler
  open func photoViewerController(_ photoViewerController: DTPhotoViewerController, configurePhotoAt index: Int, withImageView imageView: UIImageView) {
    photoConfigurationHandler(photoViewerController, index, core.itemIdentifier(for: index), imageView)
  }

  public typealias CellConfigurationHandler = (DTPhotoViewerController, DTPhotoCollectionViewCell, Int, ItemIdentifierType) -> Void
  public var cellConfigurationHandler: CellConfigurationHandler?
  open func photoViewerController(_ photoViewerController: DTPhotoViewerController, configureCell cell: DTPhotoCollectionViewCell, forPhotoAt index: Int) {
    cellConfigurationHandler?(photoViewerController, cell, index, core.itemIdentifier(for: index))
  }

  public var referencedViewProvider: ((Int, ItemIdentifierType) -> UIView?)?
  open func photoViewerController(_ photoViewerController: DTPhotoViewerController, referencedViewForPhotoAt index: Int) -> UIView? {
    referencedViewProvider?(index, core.itemIdentifier(for: index))
  }
}
