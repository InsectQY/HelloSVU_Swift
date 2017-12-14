//
//  BusRouteDetailHeaderView.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteDetailHeaderView: UIView,NibLoadable {

    @IBOutlet fileprivate weak var distanceLabel: UILabel!
    @IBOutlet fileprivate weak var durationLabel: UILabel!
    @IBOutlet fileprivate weak var walkNaviBtn: UIButton!
    
    var walking : AMapWalking? {
        
        didSet {
            
            durationLabel.text = CalculateTool.getDuration(walking?.duration ?? 0)
            durationLabel.isHidden = (walking?.duration == 0)
            walkNaviBtn.isHidden = (walking?.duration == 0)
            distanceLabel.text = CalculateTool.getWalkDistance(CGFloat(walking?.distance ?? 0))
        }
    }
}
