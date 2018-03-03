//
//  OnePictureCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class OnePictureCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var thumbNailImg: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    var news: SingleNews? {
        
        didSet {
            
            thumbNailImg.setImage(news?.thumbnail, "placeholder")
            titleLabel.text = news?.title
            sourceLabel.text = news?.source
        }
    }
}
