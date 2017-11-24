//
//  BusRouteDetailViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let BusRouteDetailLineCellID = "BusRouteDetailLineCellID"
fileprivate let BusRouteDetailCellID = "BusRouteDetailCellID"
fileprivate let BusRouteDetailCellHeaderID = "BusRouteDetailCellHeaderID"
fileprivate let BusRouteDetailCellFooterID = "BusRouteDetailCellFooterID"

class BusRouteDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    /// 点击cell后底部弹出的位置信息窗口
    fileprivate let window : UIWindow = UIWindow()
    /// 窗口背后的黑色蒙版
    fileprivate let hudWindow : UIWindow = UIWindow()
    
    /// 公交路径规划方案
    var route = AMapRoute()
    /// 点击的是哪一个方案
    var selIndex = 0
    /// 起点
    var originLoc = ""
    /// 终点
    var destinationLoc = ""
    /// 当前选择的公交线路
    fileprivate var selBusLineIndex = 0
    
    // MARK: - LazyLoad
    fileprivate lazy var busSegment: [BusSegment] = {
        
        var busSegment = [BusSegment]()
        for _ in 0 ..< route.transits[selIndex].segments.count {
            busSegment.append(BusSegment())
        }
        return busSegment
    }()
    
    fileprivate lazy var headerView: BusRouteDetailHeaderView = {
        
        var headerView = BusRouteDetailHeaderView.loadFromNib()
        return headerView
    }()
    
    fileprivate lazy var footerView : BusRouteDetailFooterView = {
        
        var footerView = BusRouteDetailFooterView.loadFromNib()
        return footerView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension BusRouteDetailViewController {
    
    fileprivate func setUpUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        setUpCollectionView()
        setUpTableView()
        setUpTableViewHeader()
        setUpTableViewFooter()
    }
    
    // MARK: - 设置 collecitonView
    fileprivate func setUpCollectionView() {
        
        pageControl.numberOfPages = route.transits.count
        pageControl.currentPage = selIndex
        
        flowLayout.itemSize = CGSize(width: ScreenW, height: 100)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView.register(UINib(nibName: "BusRouteDetailLineCell", bundle: nil), forCellWithReuseIdentifier: BusRouteDetailLineCellID)
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        var offset = collectionView.contentOffset
        offset.x = CGFloat(selIndex) * ScreenW
        collectionView.setContentOffset(offset, animated: false)
    }
    
    fileprivate func setUpTableView() {
        
        tableView.register(UINib(nibName: "BusRouteDetailCell", bundle: nil), forCellReuseIdentifier: BusRouteDetailCellID)
        tableView.register(UINib(nibName: "BusRouteDetailCellHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: BusRouteDetailCellHeaderID)
        tableView.register(UINib(nibName: "BusRouteDetailCellFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: BusRouteDetailCellFooterID)
        tableView.rowHeight = 25
        tableView.reloadData()
    }
    
    // MARK: - 刷新界面所有数据
    fileprivate func reloadAllData() {
        
        setUpTableViewHeader()
        setUpTableViewFooter()
        tableView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension BusRouteDetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return route.transits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusRouteDetailLineCellID, for: indexPath) as! BusRouteDetailLineCell
        cell.transit = route.transits[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BusRouteDetailViewController : UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == collectionView {
            
            selIndex = Int(collectionView.contentOffset.x / ScreenW)
            pageControl.currentPage = selIndex
            busSegment.removeAll()
            for _ in 0 ..< route.transits[selIndex].segments.count {
                busSegment.append(BusSegment())
            }
            reloadAllData()
        }
    }
}

// MARK: - UITableViewDataSource
extension BusRouteDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return route.transits[selIndex].segments.count - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if busSegment[section].isOpen {
            return route.transits[selIndex].segments[section].buslines[selBusLineIndex].viaBusStops.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BusRouteDetailCellID, for: indexPath) as! BusRouteDetailCell
        cell.busStop = route.transits[selIndex].segments[indexPath.section].buslines[selBusLineIndex].viaBusStops[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BusRouteDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let segment = route.transits[selIndex].segments[section]
        let info = busSegment[section]
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BusRouteDetailCellHeaderID) as! BusRouteDetailCellHeader
        headerView.info = info
        headerView.segment = segment
        
        // 途径站点按钮点击 (上下箭头)
        headerView.viaBtnClick = {[weak self] () in
            
            self?.busSegment[section].isOpen = !(self?.busSegment[section].isOpen ?? false)
            
            if (self?.busSegment[section].isOpen ?? false) {
                self?.openSection(section)
            } else {
                self?.closeSection(section)
            }
        }
        
        // 其他公交换乘线路点击
        headerView.otherBusLineClick = {[weak self] () in
            
            let allLineVc = AllBusLineViewController()
            allLineVc.segment = segment
            allLineVc.selBusLineIndex = info.busLineIndex
            self?.showBottomView(allLineVc, section)
            
            // 点击切换了其他公交线路
            allLineVc.changeBusLine = {[weak self] (selLineIndex) in
                
                self?.busSegment[section].isSpecified = true
                self?.busSegment[section].busLineIndex = selLineIndex
                self?.reloadAllData()
            }
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: BusRouteDetailCellFooterID) as! BusRouteDetailCellFooter
        footerView.info = busSegment[section];
        footerView.segment = route.transits[selIndex].segments[section];
        // 加一是为了加载到最后一组只有步行路线的数据(默认不取最后一组)
        footerView.walking = route.transits[selIndex].segments[section + 1].walking;
        return footerView
    }
}

// MARK: - 设置UITableView头部尾部视图
extension BusRouteDetailViewController {
    
    fileprivate func setUpTableViewHeader() {
        
        let contentHeader = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 100))
        headerView.frame = contentHeader.bounds
        contentHeader.addSubview(headerView)
        tableView.tableHeaderView = contentHeader
        
        headerView.walking = route.transits[selIndex].segments[0].walking
    }
    
    fileprivate func setUpTableViewFooter() {
        
        let contentFooter = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 40))
        footerView.frame = contentFooter.bounds
        contentFooter.addSubview(footerView)
        tableView.tableFooterView = contentFooter
    }
}

// MARK: - 展开关闭列表
extension BusRouteDetailViewController {
    
    fileprivate func openSection(_ section : Int) {
        tableView.insertRows(at: getIndexData(section), with: .fade)
    }
    
    fileprivate func closeSection(_ section : Int) {
        tableView.deleteRows(at: getIndexData(section), with: .fade)
    }
    
    /// 获得需要展开的数据
    fileprivate func getIndexData(_ section : Int) -> [IndexPath] {
        
        var indexArray = [IndexPath]()
        for i in 0 ..< route.transits[selIndex].segments[section].buslines[selBusLineIndex].viaBusStops.count {
            indexArray.append(IndexPath(row: i, section: section))
        }
        return indexArray
    }
}

// MARK: - 显示底部控制器
extension BusRouteDetailViewController {

    fileprivate func showBottomView(_ viewController : AllBusLineViewController,_ selSegmentIndex : Int) {
        
        var contentH =  CGFloat(route.transits[selIndex].segments[selSegmentIndex].buslines.count * 60 + 90)
        contentH = contentH >= ScreenH ? ScreenH : contentH
        SVUAnimation.showBottomView(viewController, viewHeight: contentH, animateDuration: 0.4, completion: nil)
    }
}
