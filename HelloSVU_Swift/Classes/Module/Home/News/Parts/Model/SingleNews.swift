//
//  SingleNews.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import Foundation
import HandyJSON

struct SingleNews: HandyJSON {
    
    /// 图片类型
    enum infoType: String {
        
        case NoImg = "singletitle"
        case SignalImg = "titleimg"
        case MultiImg = "slideimg" //图片大于等于三张
        case BigImg = "bigimg"
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
    var infoType: infoType {
        
        get {
            return SingleNews.infoType(rawValue: style.view) ?? .NoImg
        }
    }
    /// cell的高度
    var rowHeight: CGFloat {
        
        get {
            
            let titleFont = PFR18Font
            if self.infoType == .SignalImg {
                return 136
            }else if self.infoType == .NoImg {
                return title.sizeWithConstrainedWidth(ScreenW - 20, titleFont).height
            }else if self.infoType == .MultiImg {
                
                let imageH = (ScreenW - 40) / 3 * 0.75
                return title.sizeWithConstrainedWidth(ScreenW - 20, titleFont).height + imageH + 56
            }
            return 120
        }
    }
    /// 新闻类型(一张图三张图)
    var style = Style()
    
    /**
     详情页面展示类型
     1.phvideo: 视频
     2.doc: 普通
     3.slide: 轮播
     4.topic2: 专题
     5.text_live: 直播
     6 web: 网页
     */
    var type = ""
    /// 新闻详情链接
    var link = Link()
}

struct Link: HandyJSON {
    
    /// 需要自己设置 JS 交互
    var url = ""
    /// 可直接加载的网页
    var weburl = ""
}

struct Style: HandyJSON {
    
    /// 图片
    var images: [String] = []
    /// 轮播数量
    var slideCount = 0
    /**
     列表页面展示的 cell 类型
     1.bigimg: 大图
     2.titleimg: 标题图片(thumbnail)
     3.slideimg: 三张图
     4.singletitle: 只显示标题
     */
    var view = ""
    /// 详情页的展示类型
    var type = ""
}
