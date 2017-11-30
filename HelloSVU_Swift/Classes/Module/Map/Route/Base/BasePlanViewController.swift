//
//  BasePlanViewController.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/30.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

/// 路径规划的类型
///
/// - Riding: 骑车
/// - Walking: 步行
/// - Driving: 驾车
enum routePlanType {
    
    case Riding
    case Walking
    case Driving
}

class BasePlanViewController: BaseViewController {
    
    @IBOutlet weak var mapContentView: UIView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var routePlanType : routePlanType = .Riding
    
    // MARK: - LazyLoad
    fileprivate lazy var search: AMapSearchAPI = {
        
        let search = AMapSearchAPI()
        search?.delegate = self
        return search!
    }()
    /// 骑车
    fileprivate lazy var ridingRouteRequest = AMapRidingRouteSearchRequest()
    /// 步行
    fileprivate lazy var walkRouteRequest = AMapWalkingRouteSearchRequest()
    /// 驾车
    fileprivate lazy var drivingRouteRequest: AMapDrivingRouteSearchRequest = {
        
        let drivingRouteRequest = AMapDrivingRouteSearchRequest()
        drivingRouteRequest.requireExtension = true
        return drivingRouteRequest
    }()
    
    /// 地图
    fileprivate lazy var mapView: MAMapView = {
        
        let mapView = MAMapView(frame: mapContentView.bounds)
        mapView.showsUserLocation = true
        // 追踪用户的location与heading更新
        mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
        mapView.pausesLocationUpdatesAutomatically = false
        mapView.allowsBackgroundLocationUpdates = true//iOS9以上系统必须配置
        mapView.compassOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.scaleOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.delegate = self
        return mapView
    }()
    
    /// 定位按钮
    fileprivate lazy var locationBtn: UIButton = {
        
        let locationBtn = UIButton(type: .custom)
        locationBtn.backgroundColor = .white
        locationBtn.setImage(#imageLiteral(resourceName: "location"), for: .normal)
        locationBtn.frame = CGRect(x: 10, y: mapContentView.frame.size.height - 36 - 10, width: 36, height: 36)
        locationBtn.addTarget(self, action: #selector(locatateNow), for: .touchUpInside)
        return locationBtn
    }()
    
    /// 定位到的经纬度
    fileprivate var nowCoordinate : CLLocationCoordinate2D?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension BasePlanViewController {
    
    fileprivate func setUpUI() {
        
        view.addSubview(mapView)
        view.addSubview(locationBtn)
    }
}

// MARK: - MAMapViewDelegate
extension BasePlanViewController : MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        nowCoordinate = userLocation.coordinate
    }
}

// MARK: - AMapSearchDelegate
extension BasePlanViewController : AMapSearchDelegate {
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        SVUHUD.dismiss()
    }
    
    func onRouteSearchDone(_ request: AMapRouteSearchBaseRequest!, response: AMapRouteSearchResponse!) {
        
    }
}

// MARK: - 按钮点击事件
extension BasePlanViewController {

    @objc fileprivate func locatateNow() {
        
        mapView.setZoomLevel(16.5, animated: true)
    }
}
