//
//  MapToolView.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/2.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MapToolView: UIView {
    
    var didClick : ((Int) -> ())?
    
    convenience init(_ frame : CGRect ,  _ content : [String]) {

        self.init(frame: frame)
        self.backgroundColor = UIColor.init(r: 255, g: 255, b: 255, a: 0.7)
        let width = self.bounds.width / CGFloat(content.count)
        for (index,item) in content.enumerated() {
            
            let toolBtn = UIButton(type: .custom)
            toolBtn.tag = index
            toolBtn.setTitle(item, for: .normal)
            toolBtn.setTitleColor(.black, for: .normal)
            toolBtn.addTarget(self, action: #selector(toolBtnDidClick(_:)), for: .touchUpInside)
            toolBtn.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: self.bounds.height)
            toolBtn.titleLabel?.font = PFR14Font
            self.addSubview(toolBtn)
        }
    }
    
    // MARK: - 按钮点击事件
    @objc fileprivate func toolBtnDidClick(_ button : UIButton ) {
        
        if let didClick = didClick{
            didClick(button.tag)
        }
    }
}
