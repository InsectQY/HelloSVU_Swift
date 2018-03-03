//
//  HomeToolContentCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import EZSwiftExtensions

private let HomeToolContentY: CGFloat = 15
private let HomeToolContentX: CGFloat = 40
private let maxCol: CGFloat = 3
private let HomeToolCellH: CGFloat = (toolCellH - HomeToolContentY) * 0.5
private let HomeToolCellW: CGFloat = ScreenW / maxCol

class HomeToolContentCell: UITableViewCell,NibReusable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    private lazy var homeData: [Home] = [Home]()
    
    var home: [Home]? {
        
        didSet {
            
            guard let home = home else {return}
            homeData = home
            collectionView.reloadData()
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: HomeToolCellW, height: HomeToolCellH)
        collectionView.contentInset = UIEdgeInsetsMake(HomeToolContentY, 0, 0, 0)
        collectionView.register(cellType: HomeToolCell.self)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeToolContentCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeToolCell.self)
        cell.home = homeData[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeToolContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = GetVc.getVcFromString(homeData[indexPath.item].vcName)
        vc.title = homeData[indexPath.item].title
        ez.topMostVC?.pushVC(vc)
    }
}
