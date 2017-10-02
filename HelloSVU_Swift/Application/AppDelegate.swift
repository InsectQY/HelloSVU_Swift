//
//  AppDelegate.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/7.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setUpRootViewController()
        setUpAmapKey()
        return true
    }
}

// MARK: - 基础设置
extension AppDelegate {
    
    // MARK: - 设置根控制器
    fileprivate func setUpRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
    
    // MARK: - 设置根控制器
    fileprivate func setUpAmapKey() {
        
        AMapServices.shared().apiKey = "c450c1752c0eaa15b1e0fb60a50560c4"
        AMapServices.shared().enableHTTPS = true
    }
}

