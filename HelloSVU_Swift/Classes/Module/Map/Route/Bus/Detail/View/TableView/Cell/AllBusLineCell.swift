//
//  AllBusLineCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class AllBusLineCell: UITableViewCell,ReuseInterface {

    @IBOutlet weak var selImage: UIImageView!
    @IBOutlet weak var busLineNameLabel: UILabel!
    @IBOutlet weak var busLineDetaiLabel: UILabel!
    
    var busLine : AMapBusLine? {
        
        didSet {
            
            busLineNameLabel.text = busLine?.name
            
            let detail = "上：\(busLine?.departureStop.name ?? "")  下：\(busLine?.arrivalStop.name ?? "")"
            var attrDetail = detail.colorSubString("上", color: UIColor(r: 70, g: 135, b: 255, a: 1.0))
            attrDetail = detail.colorSubString("下", color: UIColor(r: 70, g: 135, b: 255, a: 1.0))
            busLineDetaiLabel.attributedText = attrDetail
        }
    }
    
}
