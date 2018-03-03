//
//  ImgVerticalCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/27.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class ImgVerticalCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageView: UIImageView!
    // MARK: - LazyLoad
    var vertical: ImgVertical? {
        
        didSet {
            imageView.setImage(vertical?.thumb, "placeholder")
        }
    }
}
