//
//  NavigationController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fd_fullscreenPopGestureRecognizer.isEnabled = true
        
        // 导航栏背景和文字设置
        let naviBar : UINavigationBar = UINavigationBar.appearance()
        naviBar.setBackgroundImage(#imageLiteral(resourceName: "navigationbarBackgroundWhite"), for: .default)
        naviBar.titleTextAttributes = {[
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: PFM18Font
            ]}()
    }
    
    // MARK: - 全屏滑动返回
    private func pop() {
        
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count >= 1 {
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(normalImg: "navigationButtonReturn", highlightedImg: "navigationButtonReturnClick", title: "返回", size: nil, target: self, action: #selector(self.backBtnDidClick))
            // 隐藏要push的控制器的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - 返回点击事件
extension NavigationController {
    
    @objc private func backBtnDidClick() {
        popViewController(animated: true)
    }
}
