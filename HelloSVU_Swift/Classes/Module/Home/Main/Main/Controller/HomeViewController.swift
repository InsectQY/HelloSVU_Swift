//
//  HomeViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let NotificationCellID = "NotificationCellID"
fileprivate let HomeToolContentCellID = "HomeToolContentCellID"
fileprivate let cycleViewH : CGFloat = (ScreenH - 113) * 0.35
fileprivate let notificationCellH : CGFloat = (ScreenH - 113) * 0.25

let toolCellH : CGFloat = (ScreenH - 113) * 0.4

class HomeViewController: BaseViewController {
    
    // MARK: - LazyLoad
    fileprivate lazy var homeData: [Home] = [Home]()
    
    fileprivate lazy var cycleView : QYCycleView = {
        
        let cycleView = QYCycleView.viewFromXib()
        cycleView.frame = CGRect(x: 0, y: 0, width:ScreenW, height: cycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: NotificationCellID)
        tableView.register(UINib(nibName: "HomeToolContentCell", bundle: nil), forCellReuseIdentifier: HomeToolContentCellID)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHomeData()
        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension HomeViewController {
    
    fileprivate func setUpUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        setUpTableHeaderView()
    }
    
    // MARK: - 设置轮播图
    fileprivate func setUpTableHeaderView() {
        
        let cycleData : [String] = [cycleImage1,cycleImage2,cycleImage3,cycleImage4,cycleImage5]
        
        cycleView.cycleData = cycleData
        tableView.tableHeaderView = cycleView
    }
}

// MARK: - 加载首页底部数据
extension HomeViewController {
    
    func loadHomeData() {
        
        if let path = Bundle.main.path(forResource: "Home.plist", ofType: nil), let home = NSArray(contentsOfFile: path) as? [[String: Any]] {
            
            for dict in home {
                homeData.append(Home(dict :dict))
            }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCellID, for: indexPath) as! NotificationCell
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeToolContentCellID, for: indexPath) as! HomeToolContentCell
            cell.home = homeData
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("------")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? notificationCellH : toolCellH
    }
}
