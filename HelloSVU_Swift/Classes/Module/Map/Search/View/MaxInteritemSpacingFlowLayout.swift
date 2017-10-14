//
//  MaxInteritemSpacingFlowLayout.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/14.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MaxInteritemSpacingFlowLayout: UICollectionViewFlowLayout {

    var maximumInteritemSpacing : CGFloat = 8.0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributes = super.layoutAttributesForElements(in: rect)
        if let attributes = attributes {
            
            //第0个 cell 没有上一个 cell，所以从1开始
            for i in 1 ..< attributes.count {
                
                let curAttr = attributes[i]
                let preAttr = attributes[i - 1]
                let origin = preAttr.frame.maxX
                //根据  maximumInteritemSpacing 计算出的新的 x 位置
                let targetX = origin + maximumInteritemSpacing
                // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
                if curAttr.frame.maxX > targetX {
                    
                    if targetX + curAttr.frame.width < collectionViewContentSize.width {
                        
                        var frame = curAttr.frame
                        frame.origin.x = targetX
                        curAttr.frame = frame
                    }
                }
            }
        }
        return attributes
    }
}
