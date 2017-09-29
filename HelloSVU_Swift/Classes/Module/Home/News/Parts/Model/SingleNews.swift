//
//  SingleNews.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import HandyJSON

class SingleNews:  HandyJSON{

    /// 图片类型
    enum infoType {
        case NoImg
        case SignalImg
        case MultiImg //图片大于等于三张
        case BigImg
    }
    /// 图片
    var thumbnail = ""
    /// 标题
    var title = ""
    /// 新闻来源
    var source = ""
    /// 更新时间
    var updateTime = ""
    /// cell 类型
    var infoType : infoType = .NoImg
    /// cell的高度
    var rowHeight : CGFloat {
        get {
            return 200
        }
    }
    /// 新闻类型(一张图三张图)
    var style = Style()
    
    /**
     详情页面展示类型
     1.phvideo : 视频
     2.doc : 普通
     3.slide : 轮播
     4.topic2 : 专题
     5.text_live : 直播
     6 web : 网页
     */
    var type = ""
    /// 新闻详情链接
    var link = Link()
    
    required init() {}
}
