//
//  NormalNewsDetailViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/30.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

private let clickInfo = "myweb:imageClick:"

class NormalNewsDetailViewController: BaseViewController {
    
    var url = ""
    private lazy var allImages = [String]()
    
    // MARK: - LazyLoad
    private lazy var webView: UIWebView = {
        
        let webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        return webView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadDetailNews()
    }
}

// MARK: - 设置 UI 界面
extension NormalNewsDetailViewController {
    
    private func setUpUI() {
        
        view.addSubview(webView)
    }
}

// MARK: - 加载详情新闻数据
extension NormalNewsDetailViewController {
    
    private func loadDetailNews() {
        
        QYRequestTool.requestData(.GET, url, successComplete: {[weak self] (JSON) in
            
            var html = ""
            if let path = Bundle.main.path(forResource: "SVUNews.css", ofType: nil) {

                let newsCSS = NSURL.fileURL(withPath: path)
                let css = "<html><head><link rel=\"stylesheet\" href=\"\(newsCSS)\"></head>"
                let title = "<div class=\"title\">\(JSON["body"]["title"].description)</div>"
                let updateTime = "<div class=\"time\">\(JSON["body"]["updateTime"].description)</div>"
                let content = "<div class=\"detailInfo\">\(JSON["body"]["text"])</div>"
                html += css
                html += title
                html += updateTime
                html += content
                self?.webView.loadHTMLString(html, baseURL: nil)
            }
        }) { (Error) in
            
        }
    }
}

// MARK: - UIWebViewDelegate
extension NormalNewsDetailViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        /// 获取网页中所有图片 URL，并添加点击事件
        let getImages = """
        function getImages() {\

            var objs = document.getElementsByTagName(\"img\");\
            var imgData = '';\
            for(var i = 0;i < objs.length; i++){\

                imgData = imgData + objs[i].src + '+';\
                objs[i].onclick = function() {\
                window.location.href = \"myweb:imageClick:\" + this.src;\
            };\
        };\
            return imgData;\
            };
        """
        webView.stringByEvaluatingJavaScript(from: getImages)
        let urlResult = webView.stringByEvaluatingJavaScript(from: "getImages();")
        if let images = urlResult?.components(separatedBy: "+") {
            
            allImages = images
            allImages.removeLast()
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let requestString = request.url?.absoluteString ?? ""
        if  requestString.hasPrefix(clickInfo) {
            
            let imageURL = (requestString as NSString).substring(from: clickInfo.length)
            showImage(imageURL)
            return false
        }
        return true
    }
    
    // MARK: - 展示图片
    private func showImage(_ imageUrl : String) {
        
        for (index,item) in allImages.enumerated() {
            if imageUrl == item {
                
                present(SVUPhotoBrowser.browser(index, allImages), animated: true, completion: nil)
            }
        }
    }
    
}
