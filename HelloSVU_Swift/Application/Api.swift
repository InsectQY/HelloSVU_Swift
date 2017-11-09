//
//  Api.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import Foundation

/// 天气 URL
let Weather_BASE_URL = "https://free-api.heweather.com/v5/"

enum Weather {
    
    static let all = "\(Weather_BASE_URL)weather"
    static let forecast = "\(Weather_BASE_URL)forecast"
    static let now = "\(Weather_BASE_URL)now"
    static let hourly = "\(Weather_BASE_URL)hourly"
    static let suggestion = "\(Weather_BASE_URL)suggestion"
}

/// 图片分类
let imgCategoryURL = "http://service.picasso.adesk.com/v1/lightwp/category"

/// 新闻 URL
enum News {
    
    static let normal = "http://api.3g.ifeng.com/clientChannelNewsSearch"
    static let channelID = "http://api.iclient.ifeng.com/ClientNews"
}
