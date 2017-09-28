//
//  Cond.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import HandyJSON

class Cond: HandyJSON {

    /** 白天天气描述图片*/
    var code_d: String?
    /** 夜间天气描述图片*/
    var code_n: String?
    /** 白天天气描述*/
    var txt_d: String?
    /** 夜间天气描述*/
    var txt_n: String?
    /** 天气描述（实况）*/
    var txt: String?
    /** 天气描述图片（实况）*/
    var code: String?
    
    required init() {}
}
