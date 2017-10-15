//
//  SlideNewsDetailViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/1.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import EZSwiftExtensions
import FDFullscreenPopGesture

fileprivate let kScrollViewH : CGFloat = ScreenH - 200

class SlideNewsDetailViewController: UIViewController {
    
    var url = ""
    
    fileprivate lazy var slideNews = [SlideNews?]()
    fileprivate lazy var allImages = [String]()
    
    // MARK: - LazyLoad
    fileprivate lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, w: ScreenW, h: kScrollViewH))
        scrollView.backgroundColor = UIColor.black
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    // MARK: - 返回按钮
    fileprivate lazy var backBtn: UIButton = {
        
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 10, y: 20, width: 54, height: 44)
        backBtn.setBackgroundImage(UIImage(named: "night_icon_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return backBtn
    }()
    
    // MARK: - 新闻标题
    fileprivate lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel(frame: CGRect(x: 5, y: scrollView.bottom + 5 ,width: ScreenW - 55, height: 50))
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = PFR18Font
        return titleLabel
    }()
    
    // MARK: - 指示数量
    fileprivate lazy var countLabel: UILabel = {
        
        let countLabel = UILabel(frame: CGRect(x: ScreenW - 55, y: scrollView.bottom + 5 ,width: ScreenW - 55, height: 50))
        countLabel.textColor = .white
        countLabel.font = PFR16Font
        return countLabel
    }()
    
    // MARK: - 新闻内容
    fileprivate lazy var contentTextView: UITextView = {
        
        let contentTextView = UITextView(frame: CGRect(x: 5, y: titleLabel.bottom ,width: ScreenW - 15, height: 100))
        contentTextView.isEditable = false
        contentTextView.font = PFR16Font
        contentTextView.textColor = .white
        contentTextView.backgroundColor = .clear
        return contentTextView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadNewsData()
    }
}

// MARK: - 设置 UI 界面
extension SlideNewsDetailViewController {
    
    // MARK: - 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .black
        fd_prefersNavigationBarHidden = true
        view.addSubview(backBtn)
        view.addSubview(scrollView)
        view.addSubview(titleLabel)
        view.addSubview(countLabel)
        view.addSubview(contentTextView)
    }
    
    // MARK: - 设置轮播图片
    fileprivate func addAllImageView() {

        for (index,item) in slideNews.enumerated() {
            
            let index = CGFloat(index)
            let image = UIImageView(frame: CGRect(x: index * ScreenW, y: 64, w: ScreenW, h: kScrollViewH))
            image.contentMode = UIViewContentMode.scaleAspectFit
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImage)))
            allImages.append(item?.image ?? "")
            scrollView.addSubview(image)
        }
        
        setImageContent(0)
        setNewsContent(0)
    }
    
    // MARK: - 预览图片
    @objc fileprivate func showImage() {
        
        let index = Int(scrollView.contentOffset.x / ScreenW)
        present(SVUPhotoBrowser.browser(index, allImages), animated: true, completion: nil)
    }
    
    // MARK: - 返回
    @objc fileprivate func back() {
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - 加载新闻数据
extension SlideNewsDetailViewController {
    
    fileprivate func loadNewsData() {
        
        QYRequestTool.requestData(.GET, url, successComplete: {[weak self] (JSON) in
            
            let data = [SlideNews].deserialize(from: JSON["body"]["slides"].description)
            if let data = data {
                
                self?.slideNews = data
                
                let count = CGFloat((self?.slideNews.count) ?? 0)
                self?.scrollView.contentSize = CGSize(width: ScreenW * count, height: 0)
                self?.addAllImageView()
            }
        }) { (Error) in
            
        }
    }
}

// MARK: - UIScrollViewDelegate
extension SlideNewsDetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setAllContent()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        setAllContent()
    }
}

// MARK: - 往视图里添加内容
extension SlideNewsDetailViewController {
    
    fileprivate func setAllContent() {
        
        let index = Int(scrollView.contentOffset.x / ScreenW)
        setImageContent(index)
        setNewsContent(index)
    }
    
    fileprivate func setImageContent(_ index : Int) {
        
        var image = UIImageView()
        image = scrollView.subviews[index] as! UIImageView
        image.setImage(slideNews[index]?.image, "placeholder")
    }
    
    fileprivate func setNewsContent(_ index : Int) {
        
        contentTextView.text = slideNews[index]?.SVUDescription
        titleLabel.text = slideNews[index]?.title
        countLabel.text = "\(index + 1)/\(slideNews.count)"
    }
}

