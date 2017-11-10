//
//  SVUAnimation.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/10.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class SVUAnimation: NSObject {
    
    /// 只适用用于底部出现的view 其他不支持
    ///
    /// - Parameters:
    ///   - view: 需要展示的 view
    ///   - viewHeight: 显示 view 高度
    ///   - hidden: 是否隐藏
    ///   - animated: 是否需要动画
    ///   - completion: 加载完毕
    func setBottomView(_ view:UIView, viewHeight:CGFloat, hidden:Bool, animated:Bool, completion:(() -> ())?) {
        
        if view.isHidden == hidden {return}
        
        let animateDuration : TimeInterval = animated ? 1 : 0
        
        let viewH:CGFloat = viewHeight
        
        if hidden {
            
            UIView.animate(withDuration: animateDuration, animations: { ()->() in
                
                view.frame = CGRect(x: 0, y: ScreenH, width: ScreenW, height: viewH)
                
            }, completion: { (isOK) in
                
                view.isHidden = hidden
                
                completion?()
            })
            
        }else {
            
            view.isHidden = hidden
            
            UIView.animate(withDuration: animateDuration, animations: { ()->() in
                
                view.frame = CGRect(x: 0, y: ScreenH - viewH, width: ScreenW, height: viewH)
                
            }, completion: { (isOK) in
                
                completion?()
            })
        }
    }
}
