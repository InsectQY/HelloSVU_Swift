//
//  UINavigationBar-Awesome.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/25.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

private var runtimeKey = "runtimeKey"

extension UINavigationBar {
    
//    // MARK: - runtime
//    var overLay: UIView? {
//        
//        set {
//            objc_setAssociatedObject(self, &runtimeKey, overLay, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//        
//        get {
//            return objc_getAssociatedObject(self, &runtimeKey) as? UIView
//        }
//    }
    
    // MARK: - 设置背景色
    public func QYBackgroundColor(backgroundColor : UIColor) {
       
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        let overLay = objc_getAssociatedObject(self, &runtimeKey) as? UIView
        if overLay == nil {
            
            let bgView = UIView(x: 0, y: 0, w: bounds.width, h: bounds.height + 20)
            bgView.isUserInteractionEnabled = false
            bgView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            bgView.backgroundColor = backgroundColor
            subviews[0].insertSubview(bgView, at: 0)
            objc_setAssociatedObject(self, &runtimeKey, bgView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

       overLay?.backgroundColor = backgroundColor
    }
    
    // MARK: - 设置透明图
    public func QYElementsAlpha(alpha: CGFloat) {
        
        let overLay = objc_getAssociatedObject(self, &runtimeKey) as? UIView
        overLay?.alpha = alpha
//        if let leftViews : [UIView] =  value(forKey: "_leftViews") as? [UIView] {
//            
//            for subViews in leftViews {
//                subViews.alpha = alpha
//            }
//        }
//        
//        if let rightViews : [UIView] =  value(forKey: "_rightViews") as? [UIView] {
//            
//            for subViews in rightViews {
//                subViews.alpha = alpha
//            }
//        }
//        
//        if let titleView = value(forKey: "_titleView") as? UIView {
//            titleView.alpha = alpha
//        }
//        
//        for view in subviews {
//            
//            if let viewClass = NSClassFromString("UINavigationItemView") {
//                
//                if view.isKind(of: viewClass) {
//                    view.alpha = alpha
//                }
//            }
//            
//            if let viewClass = NSClassFromString("_UINavigationBarBackIndicatorView") {
//                
//                if view.isKind(of: viewClass) {
//                    view.alpha = alpha
//                }
//            }
//
//        }
        
    }

    // MARK: - 移除视图
    public func QYReset() {
        
        let overLay = objc_getAssociatedObject(self, &runtimeKey) as? UIView
        setBackgroundImage(nil, for: .default)
        overLay?.removeSubviews()
    }
}
