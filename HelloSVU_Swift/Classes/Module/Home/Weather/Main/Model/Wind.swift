//
//  Wind.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import HandyJSON

class Wind: HandyJSON {
    
    /** 风向(方向)*/
    var dir: String?
    /** 风力等级*/
    var sc: String?
    
    required init() {}
}
