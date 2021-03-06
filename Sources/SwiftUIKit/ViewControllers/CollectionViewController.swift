//
//  CollectionViewController.swift
//
//  Created by Sereivoan Yong on 3/5/21.
//

#if os(iOS)

import UIKit

open class CollectionViewController: UIViewController {

  open class var collectionViewLayoutClass: UICollectionViewLayout.Type {
    return UICollectionViewFlowLayout.self
  }

  open class var collectionViewClass: UICollectionView.Type {
    return UICollectionView.self
  }

  public let collectionViewLayout: UICollectionViewLayout

  lazy public private(set) var collectionView: UICollectionView = {
    let collectionView = Self.collectionViewClass.init(frame: UIScreen.main.bounds, collectionViewLayout: collectionViewLayout)
    collectionView.backgroundColor = .clear
    collectionView.clipsToBounds = false
    collectionView.alwaysBounceHorizontal = false
    collectionView.alwaysBounceVertical = true
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = true
    collectionView.preservesSuperviewLayoutMargins = true
    collectionView.delegate = self as? UICollectionViewDelegate
    collectionView.dataSource = self as? UICollectionViewDataSource
    collectionView.prefetchDataSource = self as? UICollectionViewDataSourcePrefetching
    if #available(iOS 11.0, *) {
      collectionView.dragDelegate = self as? UICollectionViewDragDelegate
      collectionView.dropDelegate = self as? UICollectionViewDropDelegate
    }
    return collectionView
  }()

  open var isCollectionViewRoot: Bool = false

  open var invalidatesCollectionViewLayoutLayout: Bool = true

  public init(collectionViewLayout: UICollectionViewLayout) {
    self.collectionViewLayout = collectionViewLayout
    super.init(nibName: nil, bundle: nil)
  }

  public override init(nibName: String? = nil, bundle: Bundle? = nil) {
    collectionViewLayout = Self.collectionViewLayoutClass.init()
    super.init(nibName: nibName, bundle: bundle)
  }

  public required init?(coder: NSCoder) {
    collectionViewLayout = Self.collectionViewLayoutClass.init()
    super.init(coder: coder)
  }

  open override func loadView() {
    if isCollectionViewRoot {
      view = collectionView
    } else {
      super.loadView()
    }
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    if !isCollectionViewRoot {
      collectionView.frame = view.bounds
      collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      view.addSubview(collectionView)
    }
  }

  open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    if invalidatesCollectionViewLayoutLayout {
      collectionViewLayout.invalidateLayout()
    }
  }
}

#endif
