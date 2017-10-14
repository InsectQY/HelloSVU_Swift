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
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    
    // MARK: - LazyLoad
    lazy var pageView: QYPageView = {
        
        let style = QYPageStyle()
        style.normalColor = .white
        style.selectColor = .white
        style.titleViewHeight = 27
        style.bottomLineHeight = 2
        let vc1 = BusRouteViewController()
        let vc2 = BusRouteViewController()
        let vc3 = BusRouteViewController()
        let vc4 = BusRouteViewController()
        
        let pageView = QYPageView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 27), titles: ["公交","步行","骑行","驾车"], titleStyle: style, childVcs: [vc1,vc2,vc3,vc4], parentVc: self)
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
        fd_prefersNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageContentView.addSubview(pageView)
    }
}

// MARK: - UITextFieldDelegate
extension RoutePageViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let searchVc = MapSearchViewController()
        
        if textField == originField {
           searchVc.searchBarText = "请输入起点"
        }else {
           searchVc.searchBarText = "请输入终点"
        }
        
        navigationController?.pushViewController(searchVc, animated: true)
    }
}
