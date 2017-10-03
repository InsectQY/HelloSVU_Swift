//
//  RoutePageViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/3.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class RoutePageViewController: UIViewController {
    
    @IBOutlet weak var pageContentView: UIView!
    
    // MARK: - LazyLoad
    lazy var pageView: QYPageView = {
        
        let style = QYPageStyle()
        style.normalColor = .white
        style.selectColor = .white
        let vc1 = BusRouteViewController()
        let vc2 = BusRouteViewController()
        let vc3 = BusRouteViewController()
        let vc4 = BusRouteViewController()
        
        let pageView = QYPageView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 27), titles: ["公交","步行","骑行","驾车"], titleStyle: style, childVcs: [vc1,vc2,vc3,vc4], parentVc: self)
        pageView.backgroundColor = .purple
        return pageView
    }()
    
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
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageContentView.addSubview(pageView)
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
