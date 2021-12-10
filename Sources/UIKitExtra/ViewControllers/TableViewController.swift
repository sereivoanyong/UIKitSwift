//
//  TableViewController.swift
//
//  Created by Sereivoan Yong on 12/10/21.
//

import UIKit

open class TableViewController: UIViewController {

  open class var tableViewClass: UITableView.Type {
    return UITableView.self
  }

  public let tableViewStyle: UITableView.Style

  lazy open private(set) var tableView: UITableView = {
    let tableView = Self.tableViewClass.init(frame: UIScreen.main.bounds, style: tableViewStyle)
    switch tableViewStyle {
    case .grouped, .insetGrouped:
      if #available(iOS 13.0, *) {
        tableView.backgroundColor = .systemGroupedBackground
      } else {
        tableView.backgroundColor = .groupTableViewBackground
      }

    default:
      if #available(iOS 13.0, *) {
        tableView.backgroundColor = .systemBackground
      } else {
        tableView.backgroundColor = .white
      }
      tableView.tableFooterView = UIView()
    }
    tableView.keyboardDismissMode = .interactive
    tableView.alwaysBounceHorizontal = false
    tableView.alwaysBounceVertical = true
    tableView.showsHorizontalScrollIndicator = false
    tableView.showsVerticalScrollIndicator = true
    tableView.preservesSuperviewLayoutMargins = true
    tableView.dataSource = self as? UITableViewDataSource
    tableView.delegate = self as? UITableViewDelegate
    if #available(iOS 10.0, *) {
      tableView.prefetchDataSource = self as? UITableViewDataSourcePrefetching
      if #available(iOS 11.0, *) {
        tableView.dragDelegate = self as? UITableViewDragDelegate
        tableView.dropDelegate = self as? UITableViewDropDelegate
      }
    }
    return tableView
  }()

  open var clearsSelectionOnViewWillAppear: Bool = true
  open var endEditingOnViewWillDisappear: Bool = true
  open var isTableViewRoot: Bool = false

  public init(style: UITableView.Style = .plain) {
    self.tableViewStyle = style
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder: NSCoder) {
    self.tableViewStyle = .plain
    super.init(coder: coder)
  }

  open override func loadView() {
    if isTableViewRoot {
      view = tableView
    } else {
      super.loadView()
    }
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    if !isTableViewRoot {
      tableView.frame = view.bounds
      tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      view.addSubview(tableView)
    }
  }

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if tableView.allowsSelection && clearsSelectionOnViewWillAppear {
      guard let selectedIndexPaths = tableView.indexPathsForSelectedRows, !selectedIndexPaths.isEmpty else {
        return
      }
      if let transitionCoordinator = transitionCoordinator {
        transitionCoordinator.animate(alongsideTransition: { [unowned tableView] context in
          for indexPath in selectedIndexPaths {
            tableView.deselectRow(at: indexPath, animated: context.isAnimated)
          }
        }, completion: { [unowned tableView] context in
          if context.isCancelled {
            for indexPath in selectedIndexPaths {
              tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
          }
        })
      } else {
        for indexPath in selectedIndexPaths {
          tableView.deselectRow(at: indexPath, animated: animated)
        }
      }
    }
  }

  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    if endEditingOnViewWillDisappear {
      view.endEditing(true)
    }
  }

  open override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)

    tableView.setEditing(editing, animated: animated)
  }
}
