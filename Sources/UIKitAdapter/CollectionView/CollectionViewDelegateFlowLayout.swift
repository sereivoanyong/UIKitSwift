//
//  CollectionViewDelegateFlowLayout.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

open class CollectionViewDelegateFlowLayout<SectionIdentifierType, ItemIdentifierType>: CollectionViewDelegate<SectionIdentifierType, ItemIdentifierType>, UICollectionViewDelegateFlowLayout {

  public typealias ItemSizeProvider = (UICollectionView, UICollectionViewFlowLayout, IndexPath, ItemIdentifierType) -> CGSize
  open var itemSizeProvider: ItemSizeProvider?
  open func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let flowLayout = layout as! UICollectionViewFlowLayout
    return itemSizeProvider?(collectionView, flowLayout, indexPath, core.itemIdentifier(for: indexPath)) ?? flowLayout.itemSize
  }

  public typealias SectionInsetProvider = (UICollectionView, UICollectionViewFlowLayout, Int, SectionIdentifierType) -> UIEdgeInsets
  open var sectionInsetProvider: SectionInsetProvider?
  open func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let flowLayout = layout as! UICollectionViewFlowLayout
    return sectionInsetProvider?(collectionView, flowLayout, section, core.sectionIdentifier(forSection: section)) ?? flowLayout.sectionInset
  }

  public typealias MinimumLineSpacingProvider = (UICollectionView, UICollectionViewFlowLayout, Int, SectionIdentifierType) -> CGFloat
  open var minimumLineSpacingProvider: MinimumLineSpacingProvider?
  open func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let flowLayout = layout as! UICollectionViewFlowLayout
    return minimumLineSpacingProvider?(collectionView, flowLayout, section, core.sectionIdentifier(forSection: section)) ?? flowLayout.minimumLineSpacing
  }

  public typealias MinimumInteritemSpacingProvider = (UICollectionView, UICollectionViewFlowLayout, Int, SectionIdentifierType) -> CGFloat
  open var minimumInteritemSpacingProvider: MinimumInteritemSpacingProvider?
  open func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    let flowLayout = layout as! UICollectionViewFlowLayout
    return minimumInteritemSpacingProvider?(collectionView, flowLayout, section, core.sectionIdentifier(forSection: section)) ?? flowLayout.minimumInteritemSpacing
  }

  public typealias HeaderReferenceSizeProvider = (UICollectionView, UICollectionViewFlowLayout, Int, SectionIdentifierType) -> CGSize
  open var headerReferenceSizeProvider: HeaderReferenceSizeProvider?
  open func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let flowLayout = layout as! UICollectionViewFlowLayout
    return headerReferenceSizeProvider?(collectionView, flowLayout, section, core.sectionIdentifier(forSection: section)) ?? flowLayout.headerReferenceSize
  }

  public typealias FooterReferenceSizeProvider = (UICollectionView, UICollectionViewFlowLayout, Int, SectionIdentifierType) -> CGSize
  open var footerReferenceSizeProvider: FooterReferenceSizeProvider?
  open func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    let flowLayout = layout as! UICollectionViewFlowLayout
    return footerReferenceSizeProvider?(collectionView, flowLayout, section, core.sectionIdentifier(forSection: section)) ?? flowLayout.footerReferenceSize
  }
}

#endif
