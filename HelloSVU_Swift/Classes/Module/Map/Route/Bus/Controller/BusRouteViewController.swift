//
//  BusRouteViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/3.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import DOPDropDownMenu_Enhanced

fileprivate let BusRouteCellID = "BusRouteCellID"
fileprivate let kMapsDropDownMenuH : CGFloat = 40

class BusRouteViewController: UIViewController {
    
    // MARK: - LazyLoad
    fileprivate lazy var originPoint = AMapGeoPoint()
    fileprivate lazy var destinationPoint = AMapGeoPoint()
    
    fileprivate let strategy = ["最快捷" , "最经济" , "最少换乘" , "最少步行" , "最舒适" , "不乘地铁"]
    fileprivate let time = ["现在出发"]
    
    /// 公交路径规划方案
    fileprivate var route : AMapRoute?
    
    fileprivate lazy var menu: DOPDropDownMenu = {
        
        let menu = DOPDropDownMenu(origin: CGPoint(x: 0, y: 0), andHeight: kMapsDropDownMenuH)
        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        menu?.selectDefalutIndexPath()
        menu?.delegate = self
        menu?.dataSource = self
        return menu!
    }()
    
    fileprivate lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: kMapsDropDownMenuH, w: ScreenW, h: view.frame.height - 115 - kMapsDropDownMenuH - kTitleViewH), style: .grouped)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, w: ScreenW, h: .leastNormalMagnitude))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BusRouteCell", bundle: nil), forCellReuseIdentifier: BusRouteCellID)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 120
        return tableView
    }()
    
    fileprivate lazy var search: AMapSearchAPI = {
        
        let search = AMapSearchAPI()
        search?.delegate = self
        return search!
    }()
    
    fileprivate lazy var busRouteRequest: AMapTransitRouteSearchRequest = {
        
        let busRouteRequest = AMapTransitRouteSearchRequest()
        busRouteRequest.requireExtension = true
        busRouteRequest.city = "南京"
        return busRouteRequest
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension BusRouteViewController {
    
    fileprivate func setUpUI() {
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.backgroundColor = .white
        view.addSubview(menu)
        view.addSubview(tableView)
    }
    
    // MARK: - 设置底部
    fileprivate func setUpFooterView() {
        
        let contentView = UIView(frame: CGRect(x: 0, y: 0, w: ScreenW, h: 40))
        let footer = BusRouteFooterView.loadFromNib()
        footer.frame = contentView.bounds
        footer.route = route
        contentView.addSubview(footer)
        tableView.tableFooterView = contentView
    }
}

// MARK: - 公交路径规划
extension BusRouteViewController {
    
    func searchRoutePlanningBus(_ strategy : Int,_ originPoint : AMapGeoPoint, _ destinationPoint : AMapGeoPoint) {
        
        SVUHUD.show(.black)
        self.originPoint = originPoint
        self.destinationPoint = destinationPoint
        busRouteRequest.strategy = strategy
        busRouteRequest.origin = originPoint
        busRouteRequest.destination = destinationPoint
        search.aMapTransitRouteSearch(busRouteRequest)
    }
}

// MARK: - AMapSearchDelegate
extension BusRouteViewController : AMapSearchDelegate {
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        SVUHUD.dismiss()
    }
    
    func onRouteSearchDone(_ request: AMapRouteSearchBaseRequest!, response: AMapRouteSearchResponse!) {
        
        SVUHUD.dismiss()
        if response.route == nil {return}
        route = response.route
        setUpFooterView()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension BusRouteViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return route?.transits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BusRouteCellID, for: indexPath) as! BusRouteCell
        cell.transit = route?.transits[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BusRouteViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: BusRouteCellID, for: indexPath)
//        return cell.cellHeight ?? 0
//    }
}

// MARK: - DOPDropDownMenuDataSource
extension BusRouteViewController : DOPDropDownMenuDataSource {

    func numberOfColumns(in menu: DOPDropDownMenu!) -> Int {
        return 2
    }

    func menu(_ menu: DOPDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        return column == 0 ? strategy.count : time.count
    }
    
    func menu(_ menu: DOPDropDownMenu!, titleForRowAt indexPath: DOPIndexPath!) -> String! {
        return indexPath.column == 0 ? strategy[indexPath.row] : time[indexPath.row]
    }
}

// MARK: - DOPDropDownMenuDelegate
extension BusRouteViewController : DOPDropDownMenuDelegate {
    
    func menu(_ menu: DOPDropDownMenu!, didSelectRowAt indexPath: DOPIndexPath!) {
        
        /// 公交换乘策略：0-最快捷模式；1-最经济模式；2-最少换乘模式；3-最少步行模式；4-最舒适模式；5-不乘地铁模式
        if indexPath.column == 0 {
            searchRoutePlanningBus(indexPath.row, originPoint, destinationPoint)
        }
    }
}
