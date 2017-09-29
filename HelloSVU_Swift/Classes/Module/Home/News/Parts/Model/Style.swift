//
//  Style.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import HandyJSON

class Style: HandyJSON {

    /// 图片
    var images : [String] = []
    /// 轮播数量
    var slideCount = 0
    /**
     列表页面展示的 cell 类型
     1.bigimg : 大图
     2.titleimg : 标题图片(thumbnail)
     3.slideimg : 三张图
     4.singletitle : 只显示标题
     */
    var view = ""
    /// 详情页的展示类型
    var type = ""
    
    required init() {}
}
