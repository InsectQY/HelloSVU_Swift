//
//  MultiPicutresCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/29.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MultiPicutresCell: UITableViewCell,ReuseInterface {

    @IBOutlet fileprivate weak var timeLabel: UILabel!
    @IBOutlet fileprivate weak var sourceLabel: UILabel!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var firstImg: UIImageView!
    @IBOutlet fileprivate weak var secondImg: UIImageView!
    @IBOutlet fileprivate weak var thirdImg: UIImageView!
    
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
