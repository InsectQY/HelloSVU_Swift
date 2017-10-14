//
//  MapSearchViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/13.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let MapTipsCellID = "MapTipsCellID"

class MapSearchViewController: UIViewController {
    
    var searchBarText = ""
    
    // MARK: - LazyLoad
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.rowHeight = 70
        tableView.register(UINib(nibName: "MapTipsCell", bundle: nil), forCellReuseIdentifier: MapTipsCellID)
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage(named: "clearImage")
        searchBar.becomeFirstResponder()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autoresizingMask = .flexibleWidth
        searchBar.placeholder = searchBarText
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var search: AMapSearchAPI = {
        
        let search = AMapSearchAPI()
        search?.delegate = self
        return search!
    }()
    
    lazy var request: AMapPOIKeywordsSearchRequest = {
        
        let request = AMapPOIKeywordsSearchRequest()
        request.cityLimit = true
        // 返回扩展信息
        request.requireExtension = true
        request.city = "南京"
        return request
    }()
    
    lazy var poisResponse = [AMapPOI]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
}

// MARK: - 设置 UI 界面
extension MapSearchViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        setUpNav()
    }
    
    fileprivate func setUpNav() {
        
        let titleView = UIView(x: 0, y: 0, w: ScreenW - 64 - 32 - 10, h: 30)
        searchBar.frame = titleView.bounds
        titleView.addSubview(searchBar)
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "voice"), style: .plain, target: self, action: #selector(speechRecognition))
    }
    
    // MARK: - 语音识别
    @objc fileprivate func speechRecognition() {
        
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
}

// MARK: - UISearchBarDelegate
extension MapSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension MapSearchViewController : AMapSearchDelegate {
    
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

