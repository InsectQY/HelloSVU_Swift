//
//  SlideNewsDetailViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/1.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import SKPhotoBrowser

fileprivate let kScrollViewH : CGFloat = ScreenH - 200

class SlideNewsDetailViewController: UIViewController {
    
    var url = ""
    
    var slideNews = [SlideNews?]()
    
    // MARK: - LazyLoad
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, w: ScreenW, h: kScrollViewH))
        scrollView.backgroundColor = UIColor.black
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
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
        view.addSubview(scrollView)
    }
    
    // MARK: - 设置轮播图片
    func addAllImageView() {

        for (index,item) in slideNews.enumerated() {
            
            let index = CGFloat(index)
            let image = UIImageView(frame: CGRect(x: index * ScreenW, y: 64, w: ScreenW, h: kScrollViewH))
            scrollView.addSubview(image)
        }
        
        setImageContent(0)
    }
}

// MARK: - 加载新闻数据
extension SlideNewsDetailViewController {
    
    func loadNewsData() {
        QYRequestTool.requestData(method: .GET, URL: url, successComplete: {[weak self] (JSON) in
            
            let data = [SlideNews].deserialize(from: JSON["body"]["slides"].description)
            if let data = data {
                
                self?.slideNews = data
                
                let count = CGFloat((self?.slideNews.count) ?? 0)
                self?.scrollView.contentSize = CGSize(width: ScreenW * count, height: 0)
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
    
    func setAllContent() {
        
        setImageContent(Int(scrollView.contentOffset.x / ScreenW))
    }
    
    func setImageContent(_ index : Int) {
        
        var image = UIImageView()
        image = scrollView.subviews[index] as! UIImageView
        image.setImage(slideNews[index]?.image, "placeholder")
    }
}
