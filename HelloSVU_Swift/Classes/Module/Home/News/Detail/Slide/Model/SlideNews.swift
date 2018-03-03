//
//  SlideNews.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/30.
//  Copyright © 2017年 Insect. All rights reserved.
//

import Foundation
import HandyJSON

struct SlideNews: HandyJSON {

    var image = ""
    var title = ""
    var SVUDescription = ""
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.SVUDescription <-- "description"
    }
}
