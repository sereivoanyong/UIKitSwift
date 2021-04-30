//
//  AppDelegate.swift
//  Example
//
//  Created by Sereivoan Yong on 4/30/21.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow()
    self.window = window
    window.rootViewController = UINavigationController(rootViewController: RootViewController())
    window.makeKeyAndVisible()
    return true
  }
}
