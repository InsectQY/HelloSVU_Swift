//
//  ReuseInterface.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/12/14.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

protocol ReuseInterface {
    
    static var ID: String { get }
    static var Nib: UINib { get }
}

extension ReuseInterface {
    
    static var ID: String {
        return String(describing: Self.self)
    }
    
    static var Nib: UINib {
        return UINib(nibName: ID, bundle: nil)
    }
}
