//
//  RoutePageViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/3.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class RoutePageViewController: UIViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension RoutePageViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        navigationController?.delegate = self
    }
}

// MARK: - UINavigationControllerDelegate
extension RoutePageViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isShowNav = viewController.isKind(of: RoutePageViewController.self)
        navigationController.setNavigationBarHidden(isShowNav, animated: false)
        let disappearingVc = navigationController.viewControllers.last
        if let disappearingVc = disappearingVc {
           disappearingVc.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}
