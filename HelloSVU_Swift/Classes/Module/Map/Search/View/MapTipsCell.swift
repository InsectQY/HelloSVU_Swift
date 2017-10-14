//
//  MapTipsCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/14.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MapTipsCell: UITableViewCell {

    @IBOutlet weak var stopLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var mapPoi: AMapPOI? {
        
        didSet {
            
            stopLabel.text = mapPoi?.address
        }
    }
}
