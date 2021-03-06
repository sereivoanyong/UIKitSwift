//
//  UICollectionViewDelegateMagazineLayout.swift
//
//  Created by Sereivoan Yong on 3/6/21.
//

#if os(iOS)

import UIKit
import MagazineLayout

extension MagazineLayout {

  final private class Box<T> {

    var value: T

    init(_ value: T) {
      self.value = value
    }
  }

  final private func associatedValue<Value>(forKey key: UnsafeRawPointer) -> Value? {
    (objc_getAssociatedObject(self, key) as? Box<Value>)?.value
  }

  final private func setAssociatedValue<Value>(_ value: Value?, forKey key: UnsafeRawPointer) {
    if let value = value {
      if let box = objc_getAssociatedObject(self, key) as? Box<Value> {
        box.value = value
      } else {
        objc_setAssociatedObject(self, key, Box<Value>(value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    } else {
      objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}

extension MagazineLayout {

  private static var itemSizeModeKey: Void?
  final public var itemSizeMode: MagazineLayoutItemSizeMode {
    get { associatedValue(forKey: &Self.itemSizeModeKey) ?? Default.ItemSizeMode }
    set { setAssociatedValue(newValue, forKey: &Self.itemSizeModeKey) }
  }

  private static var headerVisibilityModeKey: Void?
  final public var headerVisibilityMode: MagazineLayoutHeaderVisibilityMode {
    get { associatedValue(forKey: &Self.headerVisibilityModeKey) ?? Default.HeaderVisibilityMode }
    set { setAssociatedValue(newValue, forKey: &Self.headerVisibilityModeKey) }
  }

  private static var footerVisibilityModeKey: Void?
  final public var footerVisibilityMode: MagazineLayoutFooterVisibilityMode {
    get { associatedValue(forKey: &Self.footerVisibilityModeKey) ?? Default.FooterVisibilityMode }
    set { setAssociatedValue(newValue, forKey: &Self.footerVisibilityModeKey) }
  }

  private static var backgroundVisibilityModeKey: Void?
  final public var backgroundVisibilityMode: MagazineLayoutBackgroundVisibilityMode {
    get { associatedValue(forKey: &Self.backgroundVisibilityModeKey) ?? Default.BackgroundVisibilityMode }
    set { setAssociatedValue(newValue, forKey: &Self.backgroundVisibilityModeKey) }
  }

  private static var horizontalSpacingKey: Void?
  final public var horizontalSpacing: CGFloat {
    get { associatedValue(forKey: &Self.horizontalSpacingKey) ?? Default.HorizontalSpacing }
    set { setAssociatedValue(newValue, forKey: &Self.horizontalSpacingKey) }
  }

  private static var verticalSpacingKey: Void?
  final public var verticalSpacing: CGFloat {
    get { associatedValue(forKey: &Self.verticalSpacingKey) ?? Default.VerticalSpacing }
    set { setAssociatedValue(newValue, forKey: &Self.verticalSpacingKey) }
  }

  private static var sectionInsetsKey: Void?
  final public var sectionInsets: UIEdgeInsets {
    get { associatedValue(forKey: &Self.sectionInsetsKey) ?? Default.SectionInsets }
    set { setAssociatedValue(newValue, forKey: &Self.sectionInsetsKey) }
  }

  private static var itemInsetsKey: Void?
  final public var itemInsets: UIEdgeInsets {
    get { associatedValue(forKey: &Self.itemInsetsKey) ?? Default.ItemInsets }
    set { setAssociatedValue(newValue, forKey: &Self.itemInsetsKey) }
  }
}

extension UICollectionViewDelegateMagazineLayout {

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeModeForItemAt indexPath: IndexPath) -> MagazineLayoutItemSizeMode {
    return (layout as! MagazineLayout).itemSizeMode
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, visibilityModeForHeaderInSectionAtIndex index: Int) -> MagazineLayoutHeaderVisibilityMode {
    return (layout as! MagazineLayout).headerVisibilityMode
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, visibilityModeForFooterInSectionAtIndex index: Int) -> MagazineLayoutFooterVisibilityMode {
    return (layout as! MagazineLayout).footerVisibilityMode
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, visibilityModeForBackgroundInSectionAtIndex index: Int) -> MagazineLayoutBackgroundVisibilityMode {
    return (layout as! MagazineLayout).backgroundVisibilityMode
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, horizontalSpacingForItemsInSectionAtIndex index: Int) -> CGFloat {
    return (layout as! MagazineLayout).horizontalSpacing
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, verticalSpacingForElementsInSectionAtIndex index: Int) -> CGFloat {
    return (layout as! MagazineLayout).verticalSpacing
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetsForSectionAtIndex index: Int) -> UIEdgeInsets {
    return (layout as! MagazineLayout).sectionInsets
  }

  public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, insetsForItemsInSectionAtIndex index: Int) -> UIEdgeInsets {
    return (layout as! MagazineLayout).itemInsets
  }
}

#endif
