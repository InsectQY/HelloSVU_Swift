//
//  NoPictureCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class NoPictureCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var news : SingleNews? {
        didSet {
            
            titleLabel.text = news?.title
            sourceLabel.text = news?.source
        }
    }
}
