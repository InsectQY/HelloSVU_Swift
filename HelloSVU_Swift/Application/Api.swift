//
//  Api.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/9/26.
//  Copyright © 2017年 Insect. All rights reserved.
//

import Foundation
import Moya

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    
    switch type {
    case .began:
        SVUHUD.show(.black)
    case .ended:
        SVUHUD.dismiss()
    }
}

let timeoutClosure = { (endpoint: Endpoint, closure: MoyaProvider<Api>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 15
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<Api>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<Api>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum Api {
    
    case wallpaper
    case wallpaperCategory(String, Int)
}

extension Api: TargetType {
    
    var baseURL: URL {
        switch self {
        case .wallpaper:
            
            return URL(string: "http://service.picasso.adesk.com/v1/lightwp/category")!
        case .wallpaperCategory(_,_):
            return URL(string: "http://service.picasso.adesk.com/v1/lightwp/category")!
        }
    }
    
    var path: String {
        switch self {
        case let .wallpaperCategory(id, _):
            return "\(id)/vertical"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case let .wallpaperCategory(_, skip):
            return .requestParameters(parameters: ["limit": 15,
                                                   "skip": skip], encoding: URLEncoding.default)
        default:
           return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
