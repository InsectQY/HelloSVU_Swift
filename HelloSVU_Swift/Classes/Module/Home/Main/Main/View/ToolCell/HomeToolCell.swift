//
//  HomeToolCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class HomeToolCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var toolImage: UIImageView!
    @IBOutlet fileprivate weak var toolTitleLabel: UILabel!
    
    // MARK: - LazyLoad
    var home : Home? {
        
        didSet {
            
            toolImage.image = UIImage(named: home?.image ?? "")
            toolTitleLabel.text = home?.title
        }
    }
    
}
