//
//  RoutePageViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/3.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

let kTitleViewH: CGFloat = 30

class RoutePageViewController: BaseViewController {
    
    @IBOutlet private weak var originField: UITextField!
    @IBOutlet private weak var destinationField: UITextField!
    
    private lazy var originPoint = AMapGeoPoint()
    private lazy var destinationPoint = AMapGeoPoint()
    
    // MARK: - LazyLoad
    private lazy var pageView: QYPageView = {
        
        let style = QYPageStyle()
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        style.selectColor = UIColor(r: 255, g: 255, b: 255)
        style.titleViewHeight = kTitleViewH
        style.bottomLineHeight = 2
        
        var childVcs  = [UIViewController]()
        let vc = BusRouteViewController()
        childVcs.append(vc)
        
        let routeType: [routePlanType] = [.Walking,.Riding,.Driving]
        for type in routeType {
            
            let vc = BasePlanViewController()
            vc.routePlanType = type
            childVcs.append(vc)
        }
        
        let pageView = QYPageView(frame: CGRect(x: 0, y: 115, width: ScreenW, height: ScreenH - 115), titles: ["公交","步行","骑行","驾车"], titleStyle: style, childVcs: childVcs, parentVc: self)
        pageView.backgroundColor = UIColor(r: 74, g: 137, b: 255)
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
    
    private func setUpUI() {

        fd_prefersNavigationBarHidden = true
        view.addSubview(pageView)
    }
    
    // MARK: - 返回按钮点击事件
    @IBAction func backBtnDidClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension RoutePageViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let searchVc = MapSearchViewController()
        
        if textField == originField {
            
            searchVc.searchBarText = "请输入起点"
            searchVc.poiSuggestion = {[weak self] (poi) in
                
                self?.originField.text = poi.name
                if let originPoint = poi.location {
                    self?.originPoint = originPoint
                }
                self?.chooseNavType()
            }
        }else {
            
            searchVc.searchBarText = "请输入终点"
            searchVc.poiSuggestion = {[weak self] (poi) in
                
                self?.destinationField.text = poi.name
                if let destinationPoint = poi.location {
                    self?.destinationPoint = destinationPoint
                }
                self?.chooseNavType()
            }
        }
        
        navigationController?.pushViewController(searchVc, animated: true)
    }
}

// MARK: - 事件处理
extension RoutePageViewController {
    
    private func chooseNavType() {
        
        if destinationField.text == "请输入终点" {return}
        startBusRoute()
    }
    
    private func startBusRoute() {
        
        let vc = childViewControllers[0] as! BusRouteViewController
        vc.searchRoutePlanningBus(0, originPoint, destinationPoint,(originField.text ?? ""),(destinationField.text ?? ""))
    }
}
