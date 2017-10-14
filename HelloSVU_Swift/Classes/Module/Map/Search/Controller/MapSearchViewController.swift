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
        tableView.delegate = self
        tableView.dataSource = self
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
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.backgroundColor = .white
        view.addSubview(tableView)
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
        
        if let key = searchBar.text {
            
            if key.count > 0 {
               search.aMapPOIKeywordsSearch(request)
            }else {
                poisResponse.removeAll()
            }
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension MapSearchViewController : AMapSearchDelegate {
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        guard response.pois.count > 0 else {
            return
        }
        poisResponse = response.pois
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MapSearchViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poisResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MapTipsCellID, for: indexPath) as! MapTipsCell
        cell.mapPoi = poisResponse[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MapSearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
