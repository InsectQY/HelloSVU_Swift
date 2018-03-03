//
//  BusRouteDetailCellFooter.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteDetailCellFooter: UITableViewHeaderFooterView,NibReusable {

    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var arrivalStopLabel: UILabel!
    @IBOutlet private weak var exitNameBtn: UIButton!
    @IBOutlet private weak var walkNaviBtn: UIButton!
    @IBOutlet private weak var durationLabel: UILabel!
    
    /// 包含是否展开，是否有多条busline 以及选择的是第几组的信息
    var info : BusSegment?
    
    var segment : AMapSegment? {
    
        didSet {
            
            var busLineIndex = 0
            if info?.isSpecified == true {
                busLineIndex = info?.busLineIndex ?? 0
            }
            arrivalStopLabel.text = segment?.buslines[busLineIndex].arrivalStop.name
            checkEnterAndExitName()
        }
    }
    
    var walking : AMapWalking? {
        
        didSet {
            
            durationLabel.isHidden = walking?.duration == 0
            walkNaviBtn.isHidden = walking?.duration == 0
            durationLabel.text = CalculateTool.getDuration(walking?.duration ?? 0)
            distanceLabel.text = CalculateTool.getWalkDistance(CGFloat(walking?.distance ?? 0))
        }
    }
}

extension BusRouteDetailCellFooter {
    
    // MARK: - 检查是否存在进站口和出站口
    private func checkEnterAndExitName() {
        
        exitNameBtn.isHidden = (segment?.exitName.length != nil)
        if segment?.exitName.length != nil {
            exitNameBtn.setTitle("\(String(describing: segment?.exitName))出", for: .normal)
        }
    }
}
