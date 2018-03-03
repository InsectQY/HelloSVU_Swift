//
//  UIBarButtonItem-Extension.swift
//  DouYuLive
//
//  Created by Insect on 2017/4/8.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(normalImg: String, highlightedImg: String? = "",title: String? = nil ,size: CGSize? = CGSize.zero,target: Any,action:Selector) {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named:normalImg ), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = PFM16Font
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -10)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if let highlightedImg = highlightedImg {
            
            btn.setImage(UIImage(named:highlightedImg), for: .highlighted)
        }
        
        if let title = title {
            btn.setTitle(title, for: .normal)
        }
        
        if let size = size {
            btn.frame = CGRect(origin:CGPoint.zero, size: size)
        }else {
            btn.sizeToFit()
        }

        self.init(customView: btn)
    }
}
