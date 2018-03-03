//
//  QYCycleCell.swift
//  DouYuLive
//
//  Created by Insect on 2017/4/10.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import Kingfisher

class QYCycleCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!

    var cycleData : String? {
        
        didSet {
            
            iconImage.setImage(cycleData)
        }
    }
}
