//
//  Forecast.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import HandyJSON

class Forecast: HandyJSON {

    /** 天气状况*/
    var cond: Cond?
    /** 风力状况*/
    var wind: Wind?
    /** 当地日期*/
    var date: String?
    /** 湿度*/
    var hum: String?
    /** 体感温度*/
    var fl: String?
    /** 当前温度(摄氏度)*/
    var tmp: String?
    /** 降雨量(单位mm)*/
    var pcpn: String?
    /** 气压*/
    var pres: String?
    /** 能见度*/
    var vis: String?
    
    required init() {}
}
