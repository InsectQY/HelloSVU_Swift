//
//  NormalNewsDetailViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/30.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class NormalNewsDetailViewController: UIViewController {
    
    var url = ""
    
    // MARK: - LazyLoad
    lazy var webView: UIWebView = {
        
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
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        view.addSubview(webView)
    }
}

// MARK: - 加载详情新闻数据
extension NormalNewsDetailViewController {
    
    func loadDetailNews() {
        QYRequestTool.requestData(method: .GET, URL: url, successComplete: {[weak self] (JSON) in
            
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
        /// 缩放图片大小
//        let script = """
//        var script = document.createElement('script');
//        script.type = 'text/javascript';
//        script.text = \"function ResizeImages() {
//        var myimg;
//        var maxwidth = \(ScreenW - 20);
//        for(i = 0;i < document.images.length; i++){
//        myimg = document.images[i];
//        myimg.height = maxwidth / (myimg.width / myimg.height);
//        myimg.width = maxwidth;
//        }
//        }\";
//        document.getElementsByTagName('p')[0].appendChild(script);
//        """
//        print(script)
//        webView.stringByEvaluatingJavaScript(from: script)
//        webView.stringByEvaluatingJavaScript(from: "ResizeImages();")
    }
    
}
