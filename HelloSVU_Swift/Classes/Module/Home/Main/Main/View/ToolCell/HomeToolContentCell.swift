//
//  HomeToolContentCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import EZSwiftExtensions

fileprivate let HomeToolCellID = "HomeToolCellID"
fileprivate let HomeToolContentY : CGFloat = 15
fileprivate let HomeToolContentX : CGFloat = 40
fileprivate let maxCol : CGFloat = 3
fileprivate let HomeToolCellH : CGFloat = (toolCellH - HomeToolContentY) * 0.5
fileprivate let HomeToolCellW : CGFloat = ScreenW / maxCol

class HomeToolContentCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    fileprivate lazy var homeData: [Home] = [Home]()
    
    var home : [Home]? {
        
        didSet {
            
            if let home = home {
                
                homeData = home
                collectionView.reloadData()
            }
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: HomeToolCellW, height: HomeToolCellH)
        collectionView.contentInset = UIEdgeInsetsMake(HomeToolContentY, 0, 0, 0)
        collectionView.register(UINib(nibName: "HomeToolCell", bundle: nil), forCellWithReuseIdentifier: HomeToolCellID)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeToolContentCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeToolCellID, for: indexPath) as! HomeToolCell
        cell.home = homeData[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeToolContentCell : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = GetVc.getVcFromString(homeData[indexPath.item].vcName)
        vc.title = homeData[indexPath.item].title
        ez.topMostVC?.pushVC(vc)
    }
}
