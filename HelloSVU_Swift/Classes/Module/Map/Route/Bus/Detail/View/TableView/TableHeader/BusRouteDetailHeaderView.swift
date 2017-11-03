//
//  BusRouteDetailHeaderView.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteDetailHeaderView: UIView,NibLoadable {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var walkNaviBtn: UIButton!
    
    var walking : AMapWalking? {
        
        didSet {
            
            if let duration = walking?.duration {
                
            }
        }
    }
    

}
