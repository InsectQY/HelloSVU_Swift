//
//  MapViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    // MARK: - LazyLoad
    fileprivate lazy var mapView: MAMapView = {
        
        let mapView = MAMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.pausesLocationUpdatesAutomatically = false
        mapView.allowsBackgroundLocationUpdates = true
        mapView.userTrackingMode = .followWithHeading
        mapView.compassOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.scaleOrigin = CGPoint(x: mapView.scaleOrigin.x, y: 22)
        return mapView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension MapViewController {
    
    fileprivate func setUpUI() {
        
        navigationController?.delegate = self
        view.backgroundColor = .white
        view.addSubview(mapView)
    }
}

// MARK: - UINavigationControllerDelegate
extension MapViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isShowNav = viewController.isKind(of: MapViewController.self)
        navigationController.setNavigationBarHidden(isShowNav, animated: false)
    }
}
