//
//  BusRouteCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/15.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var walkingDistanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var transit : AMapTransit? {
        
        didSet {
            
            /// 价格
            costLabel.text = String(format: "%.1f元", transit?.cost ?? 0)
            
            /// 时间
            let duration = (transit?.duration ?? 0) / 60
            if duration < 60 { //时间在一小时以内
                durationLabel.text = "\(duration)分钟"
            } else {
                
                let hour = duration / 60
                let minute = duration % 60
                durationLabel.text = "\(hour)小时\(minute)分钟"
            }
            
            /// 距离
            let distance = CGFloat(transit?.walkingDistance ?? 0) / 1000.0
            if distance < 1 { //步行距离在一千米以内
                walkingDistanceLabel.text = String(format: "步行%.f米", CGFloat(transit?.walkingDistance ?? 0))
            } else {
                walkingDistanceLabel.text = String(format: "步行%.1f公里", distance)
            }
        }
    }
}
