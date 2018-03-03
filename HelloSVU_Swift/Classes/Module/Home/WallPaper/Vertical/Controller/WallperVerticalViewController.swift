//
//  WallperVerticalViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 5
/// 左右间距
private let kEdge: CGFloat = 4
/// 每行最大列数
private let kMaxCol: CGFloat = 3
/// cell 宽度
private let kItemW = (ScreenW - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
/// cell 高度
private let kItemH = kItemW * 1.7

private let ImgVerticalCellID = "ImgVerticalCellID"

class WallperVerticalViewController: BaseViewController {
    
    var id = ""
    
    // MARK: - LazyLoad
    private lazy var verticalData = [ImgVertical?]()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = kEdge
        flowLayout.minimumInteritemSpacing = kEdge
        flowLayout.sectionInset = UIEdgeInsetsMake(kEdge, kEdge, kEdge, kEdge)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: ImgVerticalCell.self)
        collectionView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
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
    
    private func setUpUI() {
        
        view.addSubview(collectionView)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpRefresh() {
        
        collectionView.mj_header = SVURefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadNewVerticalData))
        collectionView.mj_footer = SVURefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreVerticalData))
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: - 加载数据
extension WallperVerticalViewController {
    
    @objc private func loadNewVerticalData() {
        
        collectionView.mj_footer.endRefreshing()
        let parameters: [String: Any] = ["limit": 15,
                                           "skip": 0]
        QYRequestTool.requestData(.GET, "\(imgCategoryURL)/\(id)/vertical", parameters, successComplete: {[weak self] (JSON) in
            
            if let data = [ImgVertical].deserialize(from:JSON["res"]["vertical"].description) {
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
    
    @objc private func loadMoreVerticalData() {
        
        collectionView.mj_header.endRefreshing()
        let parameters: [String: Any] = ["limit": 15,
                                           "skip": verticalData.count]
        QYRequestTool.requestData(.GET, "\(imgCategoryURL)/\(id)/vertical", parameters, successComplete: {[weak self] (JSON) in
            
            if let data = [ImgVertical].deserialize(from:JSON["res"]["vertical"].description) {
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
extension WallperVerticalViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return verticalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ImgVerticalCell.self)
        cell.vertical = verticalData[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension WallperVerticalViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = WallPaperDetailViewController()
        vc.vertical = verticalData[indexPath.item]
        presentVC(vc)
    }
}
