//
//  WallperVerticalViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 5
fileprivate let kEdge : CGFloat = 4
fileprivate let kMaxCol : CGFloat = 3
fileprivate let kItemW = (ScreenW - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
fileprivate let kItemH = kItemW * 1.7

fileprivate let ImgVerticalCellID = "ImgVerticalCellID"

class WallperVerticalViewController: UIViewController {
    
    var id = ""
    
    // MARK: - LazyLoad
    
    fileprivate lazy var verticalData = [ImgVertical?]()
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = kEdge
        flowLayout.minimumInteritemSpacing = kEdge
        flowLayout.sectionInset = UIEdgeInsetsMake(kEdge, kEdge, kEdge, kEdge)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImgVerticalCell", bundle: nil), forCellWithReuseIdentifier: ImgVerticalCellID)
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension WallperVerticalViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    fileprivate func setUpRefresh() {
        
        collectionView.mj_header = SVURefreshHeader.init(refreshingTarget: self, refreshingAction: #selector(loadNewVerticalData))
        collectionView.mj_footer = SVURefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreVerticalData))
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: - 加载数据
extension WallperVerticalViewController {
    
    @objc fileprivate func loadNewVerticalData() {
        
        collectionView.mj_footer.endRefreshing()
        let parameters : [String : Any] = ["limit" : 15,
                                           "skip" : 0]
        QYRequestTool.requestData(.GET, "\(imgCategoryURL)/\(id)/vertical", parameters, successComplete: {[weak self] (JSON) in
            
            let data = [ImgVertical].deserialize(from:JSON["res"]["vertical"].description)
            if let data = data {
                self?.verticalData = data
                self?.collectionView.reloadData()
                self?.collectionView.mj_header.endRefreshing()
                self?.collectionView.mj_footer.endRefreshing()
            }
        }) {[weak self] (Error) in
            self?.collectionView.mj_header.endRefreshing()
            self?.collectionView.mj_footer.endRefreshing()
        }
    }
    
    @objc fileprivate func loadMoreVerticalData() {
        
        collectionView.mj_header.endRefreshing()
        let parameters : [String : Any] = ["limit" : 15,
                                           "skip" : verticalData.count]
        QYRequestTool.requestData(.GET, "\(imgCategoryURL)/\(id)/vertical", parameters, successComplete: {[weak self] (JSON) in
            
            let data = [ImgVertical].deserialize(from:JSON["res"]["vertical"].description)
            if let data = data {
                self?.verticalData += data
                self?.collectionView.reloadData()
                self?.collectionView.mj_header.endRefreshing()
                self?.collectionView.mj_footer.endRefreshing()
            }
        }) {[weak self] (Error) in
            self?.collectionView.mj_header.endRefreshing()
            self?.collectionView.mj_footer.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WallperVerticalViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return verticalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImgVerticalCellID, for: indexPath) as! ImgVerticalCell
        cell.vertical = verticalData[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension WallperVerticalViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = WallPaperDetailViewController()
        vc.vertical = verticalData[indexPath.item]
        presentVC(vc)
    }
}
