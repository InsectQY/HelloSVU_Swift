//
//  QYRequestTool.swift
//  DouYuLive
//
//  Created by Insect on 2017/4/9.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import HandyJSON

enum MethodType {
    case GET
    case POST
}

class QYRequestTool {
    
    class func requestData(_ method: MethodType, _ URL: String, _ parameters: [String: Any]? = nil, successComplete: ((_ result: JSON) -> ())?, failureComplete: ((_ error: Error) -> ())?) {
        
        let requestType = method == .GET ? HTTPMethod.get: HTTPMethod.post
        
        // 请求头
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//            "Accept": "text/javascript",
//            "Accept": "text/html",
//            "Accept": "text/plain"
//        ]
        
        Alamofire.request(URL, method: requestType, parameters: parameters).responseJSON { (response) in
            
            switch(response.result) {
                
            case .success(let Value):

                let json = JSON(Value)
                successComplete?(json)
            break
        
            case .failure(let error):

                failureComplete?(error)
                print("返回的错误信息是---\(error)")
            break
            }
        }
    }
}
