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
    var infoType : infoType {
        
        get {
            if style.view == "slideimg" {
                return .MultiImg
            }else if style.view == "bigimg" {
                return .BigImg
            }else if style.view == "titleimg" {
                return .SignalImg
            }else if style.view == "singletitle"{
                return .NoImg
            }else {
                return .SignalImg
            }
        }
    }
    /// cell的高度
    var rowHeight : CGFloat {
        
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
