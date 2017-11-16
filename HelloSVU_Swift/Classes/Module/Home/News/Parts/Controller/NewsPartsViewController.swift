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

class NewsPartsViewController: BaseViewController {
    
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
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension NewsPartsViewController {
    
    fileprivate func setUpUI() {
        
        view.addSubview(tableView)
    }
    
    fileprivate func setUpRefresh() {
        
        tableView.mj_header = SVURefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewInfosData))
        tableView.mj_footer = SVURefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreInfosData))
        tableView.mj_header.beginRefreshing()
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
    
    @objc fileprivate func loadNewInfosData() {
        
        tableView.mj_footer.endRefreshing()
        var parameters = getParameters()
        nowPage = 1
        parameters["page"] = nowPage
        let NewsURL = channelID == "就是名字" ? News.normal : News.channelID
        QYRequestTool.requestData(.GET, NewsURL, parameters, successComplete: {[weak self] (JSON) in

            if let data = [SingleNews].deserialize(from: JSON[0]["item"].description) {
                
                let total = JSON[0]["totalPage"].description
                if self?.nowPage == Int(total) {
                    self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                }else {
                    self?.tableView.mj_footer.endRefreshing()
                }
                self?.allNews = data
                self?.tableView.reloadData()
                self?.tableView.mj_header.endRefreshing()
            }
        }) {[weak self] (Error) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
    
    @objc fileprivate func loadMoreInfosData() {
        
        tableView.mj_header.endRefreshing()
        var parameters = getParameters()
        nowPage += 1
        parameters["page"] = nowPage
        let NewsURL = channelID == "就是名字" ? News.normal : News.channelID
        QYRequestTool.requestData(.GET, NewsURL, parameters, successComplete: {[weak self] (JSON) in

            if let data = [SingleNews].deserialize(from: JSON[0]["item"].description) {
                
                let total = JSON[0]["totalPage"].description
                if self?.nowPage == Int(total) {
                    self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                }else {
                    self?.tableView.mj_footer.endRefreshing()
                }
                self?.allNews += data
                self?.tableView.reloadData()
            }
        }) {[weak self] (Error) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsPartsViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let news = allNews[indexPath.row]
        if news?.infoType == .SignalImg {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: OnePictureCellID, for: indexPath) as! OnePictureCell
            cell.news = news
            return cell
        }else if news?.infoType == .MultiImg {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MultiPicutresCellID, for: indexPath) as! MultiPicutresCell
            cell.news = news
            return cell
        }else if news?.infoType == .BigImg {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BigImgCellID, for: indexPath) as! BigImgCell
            cell.news = news
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NoPictureCellID, for: indexPath) as! NoPictureCell
            cell.news = news
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension NewsPartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = allNews[indexPath.row]
        switch news?.type {
        case "doc"?:
            
            let vc = NormalNewsDetailViewController()
            vc.url = news?.link.url ?? ""
            navigationController?.pushViewController(vc, animated: true)
            break
        case "slide"?:
            
            let vc = SlideNewsDetailViewController()
            vc.url = news?.link.url ?? ""
            navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return allNews[indexPath.row]?.rowHeight ?? 0
    }
}

