//
//  RoutePageViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/3.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class RoutePageViewController: UIViewController {
    
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    
    fileprivate var originPoint : AMapGeoPoint?
    fileprivate var destinationPoint : AMapGeoPoint?
    
    // MARK: - LazyLoad
    fileprivate lazy var pageView: QYPageView = {
        
        let style = QYPageStyle()
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        style.selectColor = UIColor(r: 255, g: 255, b: 255)
        style.titleViewHeight = 30
        style.bottomLineHeight = 2
        let vc1 = BusRouteViewController()
        let vc2 = BusRouteViewController()
        let vc3 = BusRouteViewController()
        let vc4 = BusRouteViewController()
        
        let pageView = QYPageView(frame: CGRect(x: 0, y: 115, width: ScreenW, height: ScreenH - 115), titles: ["公交","步行","骑行","驾车"], titleStyle: style, childVcs: [vc1,vc2,vc3,vc4], parentVc: self)
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
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        fd_prefersNavigationBarHidden = true
        view.addSubview(pageView)
    }
    
    @IBAction func backBtnDidClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension RoutePageViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let searchVc = MapSearchViewController()
        
        if textField == originField {
            
            searchVc.searchBarText = "请输入起点"
            searchVc.poiSuggestion = {[weak self] (poi) in
                
                self?.originField.text = poi.name
                self?.originPoint = poi.location
                self?.chooseNavType()
            }
        }else {
            
            searchVc.searchBarText = "请输入终点"
            searchVc.poiSuggestion = {[weak self] (poi) in
                
                self?.destinationField.text = poi.name
                self?.destinationPoint = poi.location
                self?.chooseNavType()
            }
        }
        
        navigationController?.pushViewController(searchVc, animated: true)
    }
}

// MARK: - 事件处理
extension RoutePageViewController {
    
    fileprivate func chooseNavType() {
        
        if destinationField.text == "请输入终点" {return}
        startBusRoute()
    }
    
    fileprivate func startBusRoute() {
        
        let vc = BusRouteViewController()
        if let originPoint = originPoint,let destinationPoint = destinationPoint {
            vc.searchRoutePlanningBus(0, originPoint, destinationPoint)
        }
    }
}
