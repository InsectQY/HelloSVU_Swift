//
//  BusLineCell.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/10.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusLineCell: UICollectionViewCell {

    @IBOutlet private weak var busLineLabel: UILabel!
    
    var busLine: String? {
        
        didSet {
            busLineLabel.text = busLine
        }
    }
}
