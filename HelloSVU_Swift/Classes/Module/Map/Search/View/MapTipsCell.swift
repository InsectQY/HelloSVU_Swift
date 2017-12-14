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

    @IBOutlet fileprivate weak var stopLabel: UILabel!
    @IBOutlet fileprivate weak var distanceLabel: UILabel!
    @IBOutlet fileprivate weak var lineLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var flowLayout: MaxInteritemSpacingFlowLayout!
    
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
