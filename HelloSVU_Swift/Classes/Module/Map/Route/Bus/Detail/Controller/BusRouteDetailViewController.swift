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

class BusRouteDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension BusRouteDetailViewController {
    
    fileprivate func setUpUI() {
        
        if #available(iOS 11.0, *) {
            
            collectionView.contentInsetAdjustmentBehavior = .never
            tableView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.backgroundColor = .white
        setUpCollectionView()
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
        
        var offset = collectionView.contentOffset
        offset.x = CGFloat(selIndex) * ScreenW
        collectionView.setContentOffset(offset, animated: false)
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
        }
    }
}

// MARK: - UITableViewDataSource
extension BusRouteDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return route.transits[self.selIndex].segments.count - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if busSegment[section].isOpen {
            return route.transits[selIndex].segments[section].buslines[selBusLineIndex].viaBusStops.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BusRouteDetailCellID, for: indexPath) as! BusRouteDetailCell
        return cell
    }
}
