//
//  SlideNews.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/30.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import HandyJSON

class SlideNews: HandyJSON {

    var image = ""
    var title = ""
    var SVUDescription = ""
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< self.SVUDescription <-- "description"
    }
}
