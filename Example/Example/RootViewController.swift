//
//  RootViewController.swift
//  Example
//
//  Created by Sereivoan Yong on 4/30/21.
//

import UIKit

final class RootViewController: UIViewController {

  init() {
    super.init(nibName: nil, bundle: nil)

    title = "UIKitSwift Example"
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    if #available(iOS 13.0, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
  }
}
