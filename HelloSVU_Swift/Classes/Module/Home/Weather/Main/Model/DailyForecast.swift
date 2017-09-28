//
//  DailyForecast.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import HandyJSON

class DailyForecast: HandyJSON {
    
    /** 天气状况*/
    var cond: Cond?
    /** 风力状况*/
    var wind: Wind?
    /** 温度状况*/
    var tmp: Tmp?
    /** 日出日落状况*/
    var astro: Astro?
    /** 湿度*/
    var hum: String?
    /** 当地日期*/
    var date: String?
    
    required init() {}
}
