//
//  SVUHUD.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/28.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit
import SVProgressHUD

class SVUHUD: NSObject {

    class func show(_ maskType: SVProgressHUDMaskType) {
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func showInfoWithStatus(_ status: String, minimumDismissTimeInterval: TimeInterval = 1.0) {
        
        SVProgressHUD.showInfo(withStatus: status)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + minimumDismissTimeInterval) {
            SVProgressHUD.dismiss()
        }
    }
    
    class func showSuccessWithStatus(_ status: String, minimumDismissTimeInterval: TimeInterval = 1.0) {
        
        SVProgressHUD.showSuccess(withStatus: status)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + minimumDismissTimeInterval) {
            SVProgressHUD.dismiss()
        }
    }
    
    class func showErrorWithStatus(_ status: String, minimumDismissTimeInterval: TimeInterval = 1.0) {
        
        SVProgressHUD.showError(withStatus: status)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + minimumDismissTimeInterval) {
            SVProgressHUD.dismiss()
        }
    }
}
