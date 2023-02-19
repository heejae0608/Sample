//
//  AppDelegate.swift
//  Sample
//
//  Created by 히재 on 2023/02/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .systemBackground
    window?.makeKeyAndVisible()
    
    let mainVC = MainViewController()
    let naviVC = UINavigationController(rootViewController: mainVC)
    window?.rootViewController = naviVC
    
    return true
  }



}

