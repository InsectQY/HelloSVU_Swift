//
//  MultiPicutresCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MultiPicutresCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var firstImg: UIImageView!
    @IBOutlet var secondImg: UIImageView!
    @IBOutlet var thirdImg: UIImageView!
    
    var news : SingleNews? {
        
        didSet {
            
            titleLabel.text = news?.title
            sourceLabel.text = news?.source
            
            if let images = news?.style.images {
                
                for i in 0 ..< images.count {
                    
                    switch i {
                    case 0:
                        firstImg.setImage(news?.style.images[i], "placeholder")
                        break
                    case 1:
                        secondImg.setImage(news?.style.images[i], "placeholder")
                        break
                    case 2:
                        thirdImg.setImage(news?.style.images[i], "placeholder")
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
}
