//
//  KingfisherExtension.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(_ URLString : String?, _ placeHolderName : String? = nil,progress : ((_ receivedSize: Int64, _ totalSize: Int64) -> ())? = nil, completionHandler : ((_ image: Image?, _ error: NSError?, _ cacheType: CacheType, _ imageURL: URL?) -> ())? = nil) {
        
        guard let URLString = URLString else {return}
        
        guard let url = URL(string: URLString) else {return}
        
        guard let placeHolderName = placeHolderName else {
            
            kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                progress?(receivedSize,totalSize)
            }) { (image, error, cacheType, imageURL) in
                completionHandler?(image, error, cacheType, imageURL)
            }
            return
        }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName), options: nil, progressBlock: { (receivedSize, totalSize) in
            progress?(receivedSize,totalSize)
        }) { (image, error, cacheType, imageURL) in
            completionHandler?(image, error, cacheType, imageURL)
        }
    }
}
