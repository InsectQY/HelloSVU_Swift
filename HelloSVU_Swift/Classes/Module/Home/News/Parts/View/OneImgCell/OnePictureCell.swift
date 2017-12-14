//
//  OnePictureCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class OnePictureCell: UITableViewCell,ReuseInterface {

    @IBOutlet var thumbNailImg: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    
    var news : SingleNews? {
        
        didSet {
            
            thumbNailImg.setImage(news?.thumbnail, "placeholder")
            titleLabel.text = news?.title
            sourceLabel.text = news?.source
        }
    }

}
