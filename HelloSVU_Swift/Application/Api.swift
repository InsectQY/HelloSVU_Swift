//
//  Api.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import Foundation

/// 天气基础url
let Weather_BASE_URL = "https://free-api.heweather.com/v5/"
/// 全部天气
let allWeatherURL = "\(Weather_BASE_URL)weather"
/// 3-10天预报
let forecastWeatherURL = "\(Weather_BASE_URL)forecast"
/// 实况天气
let nowWeatherURL = "\(Weather_BASE_URL)now"
/// 未来每小时预报
let hourlyWeatherURL = "\(Weather_BASE_URL)hourly"
/// 生活指数
let suggestionWeatherURL = "\(Weather_BASE_URL)suggestion"


/// 图片分类
let imgCategoryURL = "http://service.picasso.adesk.com/v1/lightwp/category"

/// 新闻
let newsNormalURL = "http://api.3g.ifeng.com/clientChannelNewsSearch"
let newsChannelIDURL = "http://api.iclient.ifeng.com/ClientNews"
