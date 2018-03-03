//
//  WallPaperCategoryViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 20
/// 左右间距
private let kEdge: CGFloat = 10
/// 每行最大列数
private let kMaxCol: CGFloat = 3
/// cell 宽度
private let kItemW = (ScreenW - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
/// cell 高度
private let kItemH = kItemW * 1.618

class WallPaperCategoryViewController: BaseViewController {
    
    // MARK: - LazyLoad
    private lazy var categoryData = [ImgCategory?]()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.sectionInset = UIEdgeInsetsMake(kEdge, kEdge, kEdge, kEdge)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: ImgCategoryCell.self)
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
extension WallPaperCategoryViewController {
    
    private func setUpUI() {
        
        view.addSubview(collectionView)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpRefresh() {
        
        collectionView.mj_header = SVURefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadCategoryData))
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: - 加载分类数据
extension WallPaperCategoryViewController {
    
    @objc private func loadCategoryData() {
        
        ApiProvider.request(.wallpaper, arrayModel: ImgCategory.self, path: "res.category", success: {
            
            self.categoryData = $0
            self.collectionView.mj_header.endRefreshing()
            self.collectionView.reloadData()
        }) {
            self.collectionView.mj_header.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WallPaperCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ImgCategoryCell.self)
        cell.category = categoryData[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension WallPaperCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = WallperVerticalViewController()
        vc.title = categoryData[indexPath.item]?.name ?? ""
        vc.id = categoryData[indexPath.item]?.id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
