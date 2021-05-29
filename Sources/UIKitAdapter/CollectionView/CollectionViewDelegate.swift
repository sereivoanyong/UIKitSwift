//
//  CollectionViewDelegate.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

#if os(iOS) && canImport(UIKit)

import UIKit

open class CollectionViewDelegate<SectionIdentifierType, ItemIdentifierType>: NSObject, UICollectionViewDelegate {

  public let core: SectionDataSourceCore<SectionIdentifierType, ItemIdentifierType>

  weak open private(set) var collectionView: UICollectionView?

  public init(core: SectionDataSourceCore<SectionIdentifierType, ItemIdentifierType>, collectionView: UICollectionView) {
    self.core = core
    self.collectionView = collectionView
    super.init()

    collectionView.delegate = self
  }

  public convenience init(dataSource: CollectionViewDataSource<SectionIdentifierType, ItemIdentifierType>) {
    self.init(core: dataSource.core, collectionView: dataSource.collectionView!)
  }

  // MARK: UICollectionViewDelegate

  public typealias ShouldHighlightProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  open var shouldHighlightProvider: ShouldHighlightProvider?
  open func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
    shouldHighlightProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? true
  }

  public typealias DidHighlightHandler = (UICollectionView, IndexPath, ItemIdentifierType) -> Void
  open var didHighlightHandler: DidHighlightHandler?
  open func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    didHighlightHandler?(collectionView, indexPath, core.itemIdentifier(for: indexPath))
  }

  public typealias DidUnhighlightHandler = (UICollectionView, IndexPath, ItemIdentifierType) -> Void
  open var didUnhighlightHandler: DidUnhighlightHandler?
  open func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    didUnhighlightHandler?(collectionView, indexPath, core.itemIdentifier(for: indexPath))
  }

  public typealias ShouldSelectProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  open var shouldSelectProvider: ShouldSelectProvider?
  open func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    shouldSelectProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? true
  }

  public typealias ShouldDeselectProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  open var shouldDeselectProvider: ShouldDeselectProvider?
  open func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
    shouldDeselectProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? true
  }

  public typealias DidSelectHandler = (UICollectionView, IndexPath, ItemIdentifierType) -> Void
  open var didSelectHandler: DidSelectHandler?
  open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    didSelectHandler?(collectionView, indexPath, core.itemIdentifier(for: indexPath))
  }

  public typealias DidDeselectHandler = (UICollectionView, IndexPath, ItemIdentifierType) -> Void
  open var didDeselectHandler: DidDeselectHandler?
  open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    didDeselectHandler?(collectionView, indexPath, core.itemIdentifier(for: indexPath))
  }

  public typealias WillDisplayCellHandler = (UICollectionView, UICollectionViewCell, IndexPath, ItemIdentifierType) -> Void
  open var willDisplayCellHandler: WillDisplayCellHandler?
  open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    willDisplayCellHandler?(collectionView, cell, indexPath, core.itemIdentifier(for: indexPath))
  }

  public typealias WillDisplaySupplementaryViewHandler = (UICollectionView, UICollectionReusableView, String, IndexPath, SectionIdentifierType) -> Void
  open var willDisplaySupplementaryViewHandler: WillDisplaySupplementaryViewHandler?
  open func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    willDisplaySupplementaryViewHandler?(collectionView, view, elementKind, indexPath, core.sectionIdentifier(forSection: indexPath.section))
  }

  public typealias DidEndDisplayingCellHandler = (UICollectionView, UICollectionViewCell, IndexPath, ItemIdentifierType) -> Void
  open var didEndDisplayingCellHandler: DidEndDisplayingCellHandler?
  open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    didEndDisplayingCellHandler?(collectionView, cell, indexPath, core.itemIdentifier(for: indexPath))
  }

  public typealias DidEndDisplayingSupplementaryViewHandler = (UICollectionView, UICollectionReusableView, String, IndexPath, SectionIdentifierType) -> Void
  open var didEndDisplayingSupplementaryViewHandler: DidEndDisplayingSupplementaryViewHandler?
  open func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
    didEndDisplayingSupplementaryViewHandler?(collectionView, view, elementKind, indexPath, core.sectionIdentifier(forSection: indexPath.section))
  }

  public typealias ShouldShowMenuProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  open var shouldShowMenuProvider: ShouldShowMenuProvider?
  open func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
    shouldShowMenuProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? false
  }

  public typealias CanPerformActionProvider = (UICollectionView, Selector, IndexPath, ItemIdentifierType, Any?) -> Bool
  open var canPerformActionProvider: CanPerformActionProvider?
  open func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
    canPerformActionProvider?(collectionView, action, indexPath, core.itemIdentifier(for: indexPath), sender) ?? false
  }

  public typealias PerformActionHandler = (UICollectionView, Selector, IndexPath, ItemIdentifierType, Any?) -> Void
  open var performActionHandler: PerformActionHandler?
  open func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    performActionHandler?(collectionView, action, indexPath, core.itemIdentifier(for: indexPath), sender)
  }

  /*
  public typealias TransitionLayoutProvider = (UICollectionView, UICollectionViewLayout, UICollectionViewLayout) -> UICollectionViewTransitionLayout
  public var transitionLayoutProvider: TransitionLayoutProvider?
  open func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
    transitionLayoutProvider?(collectionView, fromLayout, toLayout) ?? UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
  }
   */

  // Focus

  /*
  public typealias CanFocusProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  public var canFocusProvider: CanFocusProvider?
  open func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
    canFocusProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath))
  }

  open func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {

  }

  open func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

  }

  open func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {

  }
   */

  public typealias TargetIndexPathForMoveProvider = (UICollectionView, IndexPath, ItemIdentifierType, IndexPath, ItemIdentifierType) -> IndexPath
  open var targetIndexPathForMoveProvider: TargetIndexPathForMoveProvider?
  open func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
    targetIndexPathForMoveProvider?(collectionView, originalIndexPath, core.itemIdentifier(for: originalIndexPath), proposedIndexPath, core.itemIdentifier(for: proposedIndexPath)) ?? proposedIndexPath
  }

  public typealias TargetContentOffsetProvider = (UICollectionView, CGPoint) -> CGPoint
  open var targetContentOffsetProvider: TargetContentOffsetProvider?
  open func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
    targetContentOffsetProvider?(collectionView, proposedContentOffset) ?? proposedContentOffset
  }

  // Editing

  @available(iOS 14.0, *)
  public typealias CanEditProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  private var _canEditProvider: Any?
  @available(iOS 14.0, *)
  open var canEditProvider: CanEditProvider? {
    get { _canEditProvider as? CanEditProvider }
    set { _canEditProvider = newValue }
  }
  @available(iOS 14.0, *)
  open func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
    canEditProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? true
  }

  // Spring Loading

  @available(iOS 11.0, *)
  public typealias ShouldSpringLoadProvider = (UICollectionView, IndexPath, ItemIdentifierType, UISpringLoadedInteractionContext) -> Bool
  private var _shouldSpringLoadProvider: Any?
  @available(iOS 11.0, *)
  open var shouldSpringLoadProvider: ShouldSpringLoadProvider? {
    get { _shouldSpringLoadProvider as? ShouldSpringLoadProvider }
    set { _shouldSpringLoadProvider = newValue }
  }
  @available(iOS 11.0, *)
  open func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
    shouldSpringLoadProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath), context) ?? true
  }

  // Multiple Selection

  @available(iOS 13.0, *)
  public typealias ShouldBeginMultipleSelectionInteractionProvider = (UICollectionView, IndexPath, ItemIdentifierType) -> Bool
  private var _shouldBeginMultipleSelectionInteractionProvider: Any?
  @available(iOS 13.0, *)
  open var shouldBeginMultipleSelectionInteractionProvider: ShouldBeginMultipleSelectionInteractionProvider? {
    get { _shouldBeginMultipleSelectionInteractionProvider as? ShouldBeginMultipleSelectionInteractionProvider }
    set { _shouldBeginMultipleSelectionInteractionProvider = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
    shouldBeginMultipleSelectionInteractionProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath)) ?? false
  }

  @available(iOS 13.0, *)
  public typealias DidBeginMultipleSelectionInteractionHandler = (UICollectionView, IndexPath, ItemIdentifierType) -> Void
  private var _didBeginMultipleSelectionInteractionHandler: Any?
  @available(iOS 13.0, *)
  open var didBeginMultipleSelectionInteractionHandler: DidBeginMultipleSelectionInteractionHandler? {
    get { _didBeginMultipleSelectionInteractionHandler as? DidBeginMultipleSelectionInteractionHandler }
    set { _didBeginMultipleSelectionInteractionHandler = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
    didBeginMultipleSelectionInteractionHandler?(collectionView, indexPath, core.itemIdentifier(for: indexPath))
  }

  @available(iOS 13.0, *)
  public typealias DidEndMultipleSelectionInteractionHandler = (UICollectionView) -> Void
  private var _didEndMultipleSelectionInteractionHandler: Any?
  @available(iOS 13.0, *)
  open var didEndMultipleSelectionInteractionHandler: DidEndMultipleSelectionInteractionHandler? {
    get { _didEndMultipleSelectionInteractionHandler as? DidEndMultipleSelectionInteractionHandler }
    set { _didEndMultipleSelectionInteractionHandler = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
    didEndMultipleSelectionInteractionHandler?(collectionView)
  }

  @available(iOS 13.0, *)
  public typealias ContextMenuConfigurationProvider = (UICollectionView, IndexPath, ItemIdentifierType, CGPoint) -> UIContextMenuConfiguration?
  private var _contextMenuConfigurationProvider: Any?
  @available(iOS 13.0, *)
  open var contextMenuConfigurationProvider: ContextMenuConfigurationProvider? {
    get { _contextMenuConfigurationProvider as? ContextMenuConfigurationProvider }
    set { _contextMenuConfigurationProvider = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    contextMenuConfigurationProvider?(collectionView, indexPath, core.itemIdentifier(for: indexPath), point)
  }

  @available(iOS 13.0, *)
  public typealias PreviewForHighlightingContextMenuProvider = (UICollectionView, UIContextMenuConfiguration) -> UITargetedPreview?
  private var _previewForHighlightingContextMenuProvider: Any?
  @available(iOS 13.0, *)
  open var previewForHighlightingContextMenuProvider: PreviewForHighlightingContextMenuProvider? {
    get { _previewForHighlightingContextMenuProvider as? PreviewForHighlightingContextMenuProvider }
    set { _previewForHighlightingContextMenuProvider = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    previewForHighlightingContextMenuProvider?(collectionView, configuration)
  }

  @available(iOS 13.0, *)
  public typealias PreviewForDismissingContextMenuProvider = (UICollectionView, UIContextMenuConfiguration) -> UITargetedPreview?
  private var _previewForDismissingContextMenuProvider: Any?
  @available(iOS 13.0, *)
  open var previewForDismissingContextMenuProvider: PreviewForDismissingContextMenuProvider? {
    get { _previewForDismissingContextMenuProvider as? PreviewForDismissingContextMenuProvider }
    set { _previewForDismissingContextMenuProvider = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionView(_ collectionView: UICollectionView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
    previewForDismissingContextMenuProvider?(collectionView, configuration)
  }

  @available(iOS 13.0, *)
  public typealias WillPerformPreviewActionForMenuHandler = (UICollectionView, UIContextMenuConfiguration, UIContextMenuInteractionCommitAnimating) -> Void
  private var _willPerformPreviewActionForMenuHandler: Any?
  @available(iOS 13.0, *)
  open var willPerformPreviewActionForMenuHandler: WillPerformPreviewActionForMenuHandler? {
    get { _willPerformPreviewActionForMenuHandler as? WillPerformPreviewActionForMenuHandler }
    set { _willPerformPreviewActionForMenuHandler = newValue }
  }
  @available(iOS 13.0, *)
  open func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
    willPerformPreviewActionForMenuHandler?(collectionView, configuration, animator)
  }

  @available(iOS 13.2, *)
  public typealias WillDisplayContextMenuHandler = (UICollectionView, UIContextMenuConfiguration, UIContextMenuInteractionAnimating?) -> Void
  private var _willDisplayContextMenuHandler: Any?
  @available(iOS 13.2, *)
  open var willDisplayContextMenuHandler: WillDisplayContextMenuHandler? {
    get { _willDisplayContextMenuHandler as? WillDisplayContextMenuHandler }
    set { _willDisplayContextMenuHandler = newValue }
  }
  @available(iOS 13.2, *)
  open func collectionView(_ collectionView: UICollectionView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    willDisplayContextMenuHandler?(collectionView, configuration, animator)
  }

  @available(iOS 13.2, *)
  public typealias WillEndContextMenuInteractionHandler = (UICollectionView, UIContextMenuConfiguration, UIContextMenuInteractionAnimating?) -> Void
  private var _willEndContextMenuInteractionHandler: Any?
  @available(iOS 13.2, *)
  open var willEndContextMenuInteractionHandler: WillEndContextMenuInteractionHandler? {
    get { _willEndContextMenuInteractionHandler as? WillEndContextMenuInteractionHandler }
    set { _willEndContextMenuInteractionHandler = newValue }
  }
  @available(iOS 13.2, *)
  open func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
    willEndContextMenuInteractionHandler?(collectionView, configuration, animator)
  }
}

#endif
