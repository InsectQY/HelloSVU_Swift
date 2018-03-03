//
//  MapTipsCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/14.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import EZSwiftExtensions

class MapTipsCell: UITableViewCell {

    @IBOutlet private weak var stopLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var lineLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: MaxInteritemSpacingFlowLayout!
    
    var keyWords = ""
    
    var mapPoi: AMapPOI? {
        
        didSet {
            
            stopLabel.text = mapPoi?.address
            nameLabel.attributedText = mapPoi?.name.colorSubString(keyWords, color: UIColor(r: 70, g: 135, b: 249))
        }
    }
}

// MARK: - 设置 UI
extension MapTipsCell {
    
    func setUpCollectionView() {
        
    }
}
