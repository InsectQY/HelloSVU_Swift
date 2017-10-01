//
//  SVUPhotoBrowser.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/1.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import SKPhotoBrowser

class SVUPhotoBrowser: NSObject {

    class func browser(_ nowIndex : Int , _ allImageURL : [String]) -> SKPhotoBrowser {
        
        SKPhotoBrowserOptions.enableSingleTapDismiss = true
        SKPhotoBrowserOptions.bounceAnimation = true
        
        var allPhoto = [SKPhoto]()
        for (index,item) in allImageURL.enumerated() {
            
            let photo = SKPhoto.photoWithImageURL(item)
            photo.caption = "\(index + 1)/\(allImageURL.count)"
            allPhoto.append(photo)
        }
        let browser = SKPhotoBrowser(photos: allPhoto)
        browser.initializePageIndex(nowIndex)
        return browser
    }
}
