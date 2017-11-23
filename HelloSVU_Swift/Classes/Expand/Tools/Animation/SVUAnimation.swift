//
//  SVUAnimation.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/10.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class SVUAnimation: NSObject {
    
    static fileprivate var window = UIWindow()
    
    static fileprivate var hudWindow = UIWindow()
    
    /// 只适用用于底部出现的view
    class func showBottomView(_ showVc:UIViewController, viewHeight:CGFloat,animateDuration : TimeInterval = 1, completion:(() -> ())?) {
        
        window.frame = CGRect(x: 0, y: ScreenH, width: ScreenW, height: viewHeight)
        window.windowLevel = UIWindowLevelNormal
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        window.rootViewController = showVc
        window.makeKeyAndVisible()
        
        hudWindow.frame = CGRect(x: 0, y: ScreenH, width: ScreenW, height: ScreenH - viewHeight)
        hudWindow.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        hudWindow.windowLevel = UIWindowLevelAlert
        hudWindow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hudDidClick)))
        hudWindow.makeKeyAndVisible()
        
        UIView.animate(withDuration: animateDuration, animations: { ()->() in
            
            window.frame = CGRect(x: 0, y: ScreenH - viewHeight, width: ScreenW, height: viewHeight)
        }, completion: { (isOK) in
            
            hudWindow.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - viewHeight)
            completion?()
        })
    }
    
    class func dismiss(animateDuration : TimeInterval = 1, completion:(() -> ())?) {
        
        UIView.animate(withDuration: animateDuration, animations: { ()->() in
            
            hudWindow.alpha = 0
            window.frame = CGRect(x: 0, y: ScreenH + 10, width: ScreenW, height: 100)
        }, completion: { (isOK) in
            
            hudWindow.frame = CGRect(x: 0, y: ScreenH + 10, width: ScreenW, height: 100)
            window.resignKey()
            hudWindow.resignKey()
            completion?()
        })
    }
}

// MARK: - 点击事件
extension SVUAnimation {
    
    @objc fileprivate func hudDidClick() {
        print("132312313")
    }
}
