//
//  BusSegment.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusSegment: NSObject {

    /// 用于判断当前cell是否展开
    var isOpen = false
    /// 是否加载指定的公交线路（适用于同一策略有多条换乘时）
    var isSpecified = false
    /// 哪一条busline
    var busLineIndex = 0
}
