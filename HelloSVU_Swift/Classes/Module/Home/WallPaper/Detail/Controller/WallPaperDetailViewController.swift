//
//  WallPaperDetailViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class WallPaperDetailViewController: BaseViewController {
    
    var vertical: ImgVertical? {
        didSet {
            imageView.setImage(vertical?.img, "placeholder")
        }
    }
    
    // MARK: - LazyLoad
    fileprivate lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        return imageView
    }()
    
    /// 触摸屏幕后弹出视图
    fileprivate lazy var contextSheet: JFContextSheet = {
        
        let contextItem1 = JFContextItem(itemName: "返回", itemIcon: "content_icon_back")
        let contextItem2 = JFContextItem(itemName: "预览", itemIcon: "content_icon_preview")
        let contextItem3 = JFContextItem(itemName: "下载", itemIcon: "content_icon_download")
        
        // 选项视图
        let contextSheet = JFContextSheet(items: [contextItem1, contextItem2, contextItem3])
        contextSheet.delegate = self
        return contextSheet
    }()
    
    /// 预览滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: ScreenW * 2, height: ScreenH)
        
        // 第一张背景
        let previewImage1 = UIImageView(image: UIImage(named: "preview_cover_clock"))
        previewImage1.frame = UIScreen.main.bounds
        
        // 第二张背景
        let previewImage2 = UIImageView(image: UIImage(named: "preview_cover_home"))
        previewImage2.frame = CGRect(x: ScreenW, y: 0, width: ScreenW, height: ScreenH)
        
        scrollView.addSubview(previewImage1)
        scrollView.addSubview(previewImage2)
        return scrollView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addGestureRecognizer()
    }
}

// MARK: - 添加手势
extension WallPaperDetailViewController {
    
    fileprivate func addGestureRecognizer() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedView(_:)))
        view.addGestureRecognizer(tapGesture)
        
        // 下滑手势
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didDownSwipeView(_:)))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - 点击事件
    @objc fileprivate func didTappedView(_ gestureRecognizer: UITapGestureRecognizer) {
        
        if contextSheet.isShow {
            contextSheet.dismiss()
        } else {
            contextSheet.startWithGestureRecognizer(gestureRecognizer, inView: view)
        }
    }
    
    // MARK: - 下滑事件
    @objc fileprivate func didDownSwipeView(_ gestureRecognizer: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - 设置 UI 界面
extension WallPaperDetailViewController {
    
    fileprivate func setUpUI() {
        
        view.addSubview(imageView)
        /// 添加第一次试用指引
        showTip()
    }
    
    // MARK: - 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // MARK: - 显示提示
    fileprivate func showTip() {
        
        // 只显示一次
        if !UserDefaults.standard.bool(forKey: "showTip") {
            
            TipView().show()
            UserDefaults.standard.set(true, forKey: "showTip")
        }
        
    }
}

// MARK: - JFContextSheetDelegate
extension WallPaperDetailViewController : JFContextSheetDelegate {
    
    func contextSheet(_ contextSheet: JFContextSheet, didSelectItemWithItemName itemName: String) {
        switch itemName {
        case "返回":
            
            dismiss(animated: true, completion: nil)
            break
        case "下载":
            
            if let image = imageView.image {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            break
        case "预览":
            
            if scrollView.superview == nil {
                view.addSubview(scrollView)
            }
            break
        default:
            break
        }
    }
    
    // MARK: - 保存图片到相册回调
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            SVUHUD.showInfoWithStatus("保存失败")
        } else {
            SVUHUD.showSuccessWithStatus("保存成功")
        }
    }
}
