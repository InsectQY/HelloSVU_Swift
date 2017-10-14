//
//  MapSearchViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/13.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MapSearchViewController: UIViewController {
    
    // MARK: - LazyLoad
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.rowHeight = 70
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage(named: "clearImage")
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension MapSearchViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        setUpNav()
    }
    
    fileprivate func setUpNav() {
        
        let titleView = UIView(x: 5, y: 7, w: ScreenW - 64 - 32 - 10, h: 30)
        searchBar.frame = titleView.bounds
        titleView.addSubview(searchBar)
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "voice"), style: .plain, target: self, action: #selector(speechRecognition))
    }
    
    @objc fileprivate func speechRecognition() {
        
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
}

// MARK: - UITableViewDataSource
//extension MapSearchViewController : UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return <#code#>
//    }
//}

