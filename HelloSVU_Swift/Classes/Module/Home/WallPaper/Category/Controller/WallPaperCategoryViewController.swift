//
//  WallPaperCategoryViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 20
fileprivate let kEdge : CGFloat = 10
fileprivate let kMaxCol : CGFloat = 3
fileprivate let kItemW = (ScreenW - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
fileprivate let kItemH = kItemW * 1.618

fileprivate let ImgCategoryCellID = "ImgCategoryCellID"

class WallPaperCategoryViewController: UIViewController {
    
    // MARK: - LazyLoad
    fileprivate lazy var categoryData = [ImgCategory?]()
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.sectionInset = UIEdgeInsetsMake(kEdge, kEdge, kEdge, kEdge)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImgCategoryCell", bundle: nil), forCellWithReuseIdentifier: ImgCategoryCellID)
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
extension WallPaperCategoryViewController {
    
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
        
        collectionView.mj_header = SVURefreshHeader.init(refreshingTarget: self, refreshingAction: #selector(loadCategoryData))
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: - 加载分类数据
extension WallPaperCategoryViewController {
    
    @objc fileprivate func loadCategoryData() {
        
        QYRequestTool.requestData(method: .GET, URL: imgCategoryURL, successComplete: {[weak self] (JSON) in
            
            let data = [ImgCategory].deserialize(from: JSON["res"]["category"].description)
            if let data = data {
                
                self?.categoryData = data
                self?.collectionView.reloadData()
                self?.collectionView.mj_header.endRefreshing()
            }
        }) {[weak self] (Error) in
            self?.collectionView.mj_header.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WallPaperCategoryViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImgCategoryCellID, for: indexPath) as! ImgCategoryCell
        cell.category = categoryData[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension WallPaperCategoryViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = WallperVerticalViewController()
        vc.title = categoryData[indexPath.item]?.name
        vc.id = categoryData[indexPath.item]?.id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
