//
//  BusRouteDetailCellHeader.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class BusRouteDetailCellHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var busLineLabel: UILabel!
    @IBOutlet weak var departureStopLabel: UILabel!
    @IBOutlet weak var viaBusStopsBtn: UIButton!
    @IBOutlet weak var enterNameBtn: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: MaxInteritemSpacingFlowLayout!
    @IBOutlet weak var timeContentView: UIView!
    @IBOutlet weak var otherBusLineView: UIView!
    
    lazy var busLines: [AMapBusLine] = {
        
        var busLines = [AMapBusLine]()
        let s : NSString = ""
        if let allLine = segment?.buslines {
            
            for line in allLine {
                
                if line.name.contains("(") {
                    
                }
            }
        }
        return busLines
    }()
    
    /// 包含是否展开，是否有多条busline 以及选择的是第几组的信息
    var info : BusSegment?
    
    var segment : AMapSegment? {
        
        didSet {
            
            if let isOpen = info?.isOpen {
                
                viaBusStopsBtn.isSelected = isOpen
                timeContentView.isHidden = isOpen
            }
            var busLineIndex = 0
            if info?.isSpecified == true {
                busLineIndex = info?.busLineIndex ?? 0
            }
            
            departureStopLabel.text = segment?.buslines[busLineIndex].departureStop.name
            busLineLabel.text = segment?.buslines[busLineIndex].name
            
            // 设置途径站点
            let count = segment?.buslines[busLineIndex].viaBusStops.count ?? 0
            if count > 0 {
                
                viaBusStopsBtn.setTitle("\(String(describing: count))站", for: .normal)
                viaBusStopsBtn.isEnabled = true
            } else {
                viaBusStopsBtn.isEnabled = false
            }
        }
    }
}
