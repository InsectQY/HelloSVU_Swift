//
//  NoPictureCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class NoPictureCell: UITableViewCell,ReuseInterface {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var sourceLabel: UILabel!
    @IBOutlet fileprivate weak var timeLabel: UILabel!
    
    var news : SingleNews? {
        
        didSet {
            
            titleLabel.text = news?.title
            sourceLabel.text = news?.source
        }
    }
}
