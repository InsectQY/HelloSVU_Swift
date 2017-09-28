//
//  Suggestion.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import HandyJSON

class Suggestion: HandyJSON {
    
    /** 穿衣指数*/
    var drsg: SuggestionDetail?
    /** 洗车指数*/
    var cw: SuggestionDetail?
    /** 紫外线指数*/
    var uv: SuggestionDetail?
    /** 运动指数*/
    var sport: SuggestionDetail?
    /** 感冒指数*/
    var flu: SuggestionDetail?
    /** 旅游指数*/
    var trav: SuggestionDetail?
    /** 舒适指数*/
    var comf: SuggestionDetail?
    
    required init() {}
}
