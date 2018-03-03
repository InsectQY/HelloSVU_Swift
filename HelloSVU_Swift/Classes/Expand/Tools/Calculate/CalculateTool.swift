//
//  CalculateTool.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/11/3.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class CalculateTool: NSObject {

    // MARK: - 获得步行距离(传入单位 "米")
    class func getWalkDistance(_ walkingDistance: CGFloat) -> String {
        
        if walkingDistance == 0 {
            return "同站换乘"
        }
        /// 距离
        let distance = walkingDistance / 1000.0
        if distance < 1 { //步行距离在一千米以内
            return String(format: "步行%.f米", walkingDistance)
        } else {
            return String(format: "步行%.1f公里", distance)
        }
    }
    
    // MARK: - 获得所花费时间(传入单位 "秒")
    class func getDuration(_ duration: Int) -> String {
        
        let duration = duration / 60
        if duration < 60 { //时间在一小时以内
            return "\(duration)分钟"
        } else {
            
            let hour = duration / 60
            let minute = duration % 60
            return "\(hour)小时\(minute)分钟"
        }
    }
}
