//
//  ImgCategory.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import HandyJSON

struct ImgCategory: HandyJSON {
    /// 图片 URL
    var cover = ""
    /// 分类名称
    var name = ""
    /// 分类id
    var id = ""
}

struct test: HandyJSON {
    
    var msg = ""
    var res: res?
}

struct res: HandyJSON {
    var category = [ImgCategory]()
}
