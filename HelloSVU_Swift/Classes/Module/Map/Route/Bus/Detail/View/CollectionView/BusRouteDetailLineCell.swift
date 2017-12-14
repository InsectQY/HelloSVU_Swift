//
//  BusRouteDetailLineCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteDetailLineCell: UICollectionViewCell,ReuseInterface {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var walkingDistanceLabel: UILabel!
    
    var transit : AMapTransit? {
        
        didSet {
            
            /// 站点换乘
            nameLabel.attributedText = (normalBusName ?? "").colorSubString("→", color: .lightGray)
            
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
    
    var normalBusName : String? {
        
        get {
            
            var segment = [AMapSegment]()
            if let segments =  transit?.segments {
                
                segment += segments
                if (segment.last?.buslines.count ?? 0) <= 0 {
                    segment.removeLast()
                }
                
                var allSeg : String = ""
                for i in 0 ..< segment.count { // 遍历所有换乘策略
                    
                    var busLine : String = ""
                    for k in 0 ..< segment[i].buslines.count { // 遍历同一换乘策略中的所有公交线路
                        
                        var tmpName = (segment[i].buslines[k].name ?? "") as NSString
                        if tmpName.contains("(") { // 去除括号里详细内容(始末站信息)
                            
                            let range = tmpName.range(of: "(")
                            tmpName = tmpName.substring(to: range.location) as NSString
                        }
                        
                        let tmpK = k
                        if (tmpK + 1) != segment[i].buslines.count {
                            //如果当前不是唯一公交线路则拼接 "/"
                            busLine += "\(tmpName)/" as String
                        }else {
                            busLine += tmpName as String
                        }
                    }
                    
                    let tmpI = i
                    if (tmpI + 1) != segment.count {
                        //如果当前不是最后一条线路则拼接 "→"
                        allSeg += "\(busLine)  →  "
                    }else {
                        allSeg += busLine
                    }
                }
                return allSeg
            }
            return ""
        }
    }
}
