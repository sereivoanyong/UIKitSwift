//
//  MagazineViewController.swift
//
//  Created by Sereivoan Yong on 3/6/21.
//

#if os(iOS)

import UIKit
import SwiftUIKit
import MagazineLayout

open class MagazineViewController: CollectionViewController {

  open override class var collectionViewLayoutClass: UICollectionViewLayout.Type {
    return MagazineLayout.self
  }

  public init(layout: MagazineLayout) {
    super.init(collectionViewLayout: layout)
  }

  public override init(nibName: String? = nil, bundle: Bundle? = nil) {
    super.init(nibName: nibName, bundle: bundle)
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.isPrefetchingEnabled = false
  }
}

#endif
