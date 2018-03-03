//
//  TipView.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class TipView: UIView {
    
    /// 透明遮罩
    private lazy var bgView: UIView = {
        
        let bgView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor(white: 0, alpha: 0)
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedBgView(_:))))
        return bgView
    }()
    
    // MARK: - 图片
    private lazy var swipeImageView: UIImageView = {
        
        let swipeImageView = UIImageView(frame: CGRect(x: 100, y: ScreenH - 200, width: 50, height: 50))
        swipeImageView.image = #imageLiteral(resourceName: "swipe_down")
        return swipeImageView
    }()
    
    // MARK: - 提示文字
    private lazy var swipeLabel: UILabel = {
        
        let swipeLabel = UILabel(frame: CGRect(x: 160, y: ScreenH - 180, width: ScreenW - 160, height: 30))
        swipeLabel.text = "可以下滑返回哦"
        swipeLabel.font = PFR18Font
        swipeLabel.textColor = .white
        return swipeLabel
    }()
    
    // MARK: - 弹出视图
    func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.addSubview(bgView)
        UIApplication.shared.keyWindow?.addSubview(swipeImageView)
        UIApplication.shared.keyWindow?.addSubview(swipeLabel)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        }, completion: { (_) in
            self.showAnimation(2)
        })
    }
    
    // MARK: - 下滑手势动画
    private func showAnimation(_ count: Int) {
        
        var animationCount = count
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            
            self.swipeImageView.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: { (_) in
            
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                
                self.swipeImageView.transform = CGAffineTransform.identity
            }, completion: { (_) in
                
                animationCount -= 1
                if animationCount > 0 {
                    self.showAnimation(animationCount)
                }
            })
        })
    }
    
    // MARK: - 透明背景遮罩触摸事件
    @objc private func didTappedBgView(_ tap: UITapGestureRecognizer) {
        dismiss()
    }
    
    // MARK: - 隐藏视图
    func dismiss() {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.swipeImageView.alpha = 0
            self.swipeLabel.alpha = 0
            self.bgView.backgroundColor = UIColor(white: 0, alpha: 0)
        }, completion: { (_) in
            
            self.bgView.removeFromSuperview()
            self.swipeImageView.removeFromSuperview()
            self.swipeLabel.removeFromSuperview()
            self.removeFromSuperview()
        })
    }
}

