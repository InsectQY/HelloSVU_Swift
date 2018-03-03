//
//  QYPageStyle.swift
//  QYPageView
//
//  Created by Insect on 2017/4/28.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class QYPageStyle {

    var titleViewHeight: CGFloat = 44
    var titleFont: UIFont = .systemFont(ofSize: 15.0)
    var isScrollEnable: Bool = false
    
    var titleMargin: CGFloat = 20

    var normalColor: UIColor = .black
    var selectColor: UIColor = .red
    
    var isShowBottomLine: Bool = true
    var bottomLineColor: UIColor = .red
    var bottomLineHeight: CGFloat = 2
    
    var isTitleScale: Bool = false
    var scaleRange: CGFloat = 1.2
    
    var isShowCoverView: Bool = false
    var coverBgColor: UIColor = .black
    var coverAlpha: CGFloat = 0.4
    var coverMargin: CGFloat = 8
    var coverHeight: CGFloat = 25
}
