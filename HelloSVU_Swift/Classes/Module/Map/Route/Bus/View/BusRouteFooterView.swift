//
//  BusRouteFooterView.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteFooterView: UIView ,NibLoadable {

    @IBOutlet weak var priceLabel: UILabel!
    
    var route : AMapRoute? {
        
        didSet {
            
            if let cost = route?.taxiCost {
                priceLabel.text = String(format: "打车约%.f元", cost)
            }else {
                priceLabel.text = "暂未获取到打车费用,去驾车规划看看"
            }
        }
    }

}
