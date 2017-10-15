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
            
            costLabel.text = String(format: "%.1f元", transit?.cost ?? 0)
        }
    }
}
