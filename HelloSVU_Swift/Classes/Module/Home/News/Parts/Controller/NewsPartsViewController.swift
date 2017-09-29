//
//  NewsPartsViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/28.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let NoPictureCellID = "NoPictureCellID"
fileprivate let OnePictureCellID = "OnePictureCellID"
fileprivate let MultiPicutresCellID = "MultiPicutresCellID"
fileprivate let BigImgCellID = "BigImgCellID"

class NewsPartsViewController: UIViewController {
    
    var titleName = ""
    var channelID = ""
    /// 当前页
    var nowPage = 1
    /// 所有新闻数据
    fileprivate lazy var allNews = [SingleNews?]()
    
    // MARK: - LazyLoad
    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NoPictureCell", bundle: nil), forCellReuseIdentifier: NoPictureCellID)
        tableView.register(UINib(nibName: "OnePictureCell", bundle: nil), forCellReuseIdentifier: OnePictureCellID)
        tableView.register(UINib(nibName: "MultiPicutresCell", bundle: nil), forCellReuseIdentifier: MultiPicutresCellID)
        tableView.register(UINib(nibName: "BigImgCell", bundle: nil), forCellReuseIdentifier: BigImgCellID)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 109, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 109, 0)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        loadNewInfosData()
    }
}

// MARK: - 设置 UI 界面
extension NewsPartsViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
}

// MARK: - 加载新闻数据
extension NewsPartsViewController {
    
    // MARK: - 请求参数
    fileprivate func getParameters() -> [String : Any] {
        
        var parameters = [String : Any]()
        parameters["proid"] = "ifengnewsvip"
        if channelID == "就是名字" {
            parameters["k"] = titleName
        }else {
            parameters["id"] = channelID
        }
        return parameters
    }
    
    fileprivate func loadNewInfosData() {
        
        var parameters = getParameters()
        parameters["page"] = nowPage
        let NewsURL = channelID == "就是名字" ? newsNormalURL : newsChannelIDURL
        QYRequestTool.requestData(method: .GET, URL: NewsURL, parameters: parameters, successComplete: {[weak self] (JSON) in
            
            let data = [SingleNews].deserialize(from: JSON[0]["item"].description)
            if let data = data {
                
                self?.allNews = data
                self?.tableView.reloadData()
            }
        }) { (Error) in
            
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsPartsViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if allNews[indexPath.row]?.infoType == .SignalImg {
            let cell = tableView.dequeueReusableCell(withIdentifier: OnePictureCellID, for: indexPath) as! OnePictureCell
            return cell
        }else if allNews[indexPath.row]?.infoType == .MultiImg {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MultiPicutresCellID, for: indexPath) as! MultiPicutresCell
            return cell
        }else if allNews[indexPath.row]?.infoType == .BigImg {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BigImgCellID, for: indexPath) as! BigImgCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoPictureCellID, for: indexPath) as! NoPictureCell
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension NewsPartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return allNews[indexPath.row]?.rowHeight ?? 5
    }
}

