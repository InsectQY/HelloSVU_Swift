//
//  ImgCategoryCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class ImgCategoryCell: UICollectionViewCell {
    
    // MARK: - LazyLoad
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var category: ImgCategory? {
        
        didSet {
            
            coverImg.setImage(category?.cover, "placeholder")
            nameLabel.text = category?.name
        }
    }
}


