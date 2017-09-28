//
//  NewsPartsViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/28.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class NewsPartsViewController: UIViewController {
    
    // MARK: - LazyLoad
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension NewsPartsViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
    }
}
