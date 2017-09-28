//
//  WeatherData.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import HandyJSON

class WeatherData: HandyJSON {

    /** 一周内天气预报*/
    var daily_forecast: [DailyForecast]?
    /** 每小时天气预报*/
    var hourly_forecast: [Forecast]?
    /** 实况天气*/
    var now: Forecast?
    /** 生活指数*/
    var suggestion: Suggestion?
    
    required init() {}
}
