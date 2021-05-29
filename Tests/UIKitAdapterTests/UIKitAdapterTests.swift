//
//  UIKitAdapterTests.swift
//
//  Created by Sereivoan Yong on 5/28/21.
//

import XCTest
@testable import UIKitAdapter

class UIKitAdapterTests: XCTestCase {

  func testDataSource() {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let dataSource = CollectionViewDataSource<String, Int>(collectionView: collectionView) { _, _, _ in
      fatalError()
    }
    do {
      var snapshot = SectionDataSourceSnapshot<String, Int>()
      snapshot.appendSection("A", items: [1, 2, 3])
      XCTAssertEqual(snapshot.numberOfSections, 1)
      XCTAssertEqual(snapshot.numberOfItems(inSection: 0), 3)
      dataSource.apply(snapshot)
      XCTAssertEqual(collectionView.numberOfSections, 1)
      XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 3)

      let currentSnapshot = dataSource.snapshot()
      XCTAssertEqual(currentSnapshot.numberOfSections, 1)
      XCTAssertEqual(currentSnapshot.numberOfItems(inSection: 0), 3)

      var newSnapshot = currentSnapshot
      newSnapshot.appendItems([4, 5])
      newSnapshot.appendSection("B", items: [6, 7, 8])
      XCTAssertEqual(newSnapshot.numberOfSections, 2)
      XCTAssertEqual(newSnapshot.numberOfItems(inSection: 0), 5)
      XCTAssertEqual(newSnapshot.numberOfItems(inSection: 1), 3)
      dataSource.apply(newSnapshot)
      XCTAssertEqual(collectionView.numberOfSections, 2)
      XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 5)
      XCTAssertEqual(collectionView.numberOfItems(inSection: 1), 3)
    }
  }
}
