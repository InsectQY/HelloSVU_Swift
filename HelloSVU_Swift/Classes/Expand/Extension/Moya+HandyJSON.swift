//
//  Moya+HandyJSON.swift
//  HelloSVU_Swift
//
//  Created by QY on 2018/3/4.
//  Copyright © 2018年 Insect. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SwiftyJSON

extension MoyaProvider {
    
    /// 请求数据（返回一个字典类型的模型）
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    dictModel: T.Type,
                                    path: String? = nil,
                                    success: ((_ returnData: T) -> ())?, failure: (() -> ())?) -> Cancellable? {
        
        return request(target, completion: {
            
            guard $0.error == nil else {
                failure?()
                return
            }
            
            guard let returnData = try? $0.value?.mapDict(dictModel.self, path) else {
                failure?()
                return
            }
            success?(returnData!)
        })
    }
    
    /// 请求数据（返回一个数组类型的模型）
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    arrayModel: T.Type,
                                    path: String? = nil,
                                    success: ((_ returnData: [T]) -> ())?, failure: (() -> ())?) -> Cancellable? {
        
        return request(target, completion: {
            
            guard $0.error == nil else {
                failure?()
                return
            }
            
            guard let returnData = try? $0.value?.mapArray(arrayModel.self, path) else {
                failure?()
                return
            }
            success?(returnData!)
        })
    }
}

extension Response {
    
    /// 转成字典模型
    ///
    /// - Parameters:
    ///   - type: 模型 Class
    ///   - path: 指定转换路径
    /// - Returns: 转换成功
    /// - Throws: 转换失败
    func mapDict<T: HandyJSON>(_ type: T.Type, _ path: String? = nil) throws -> T {
        
        guard let model = JSONDeserializer<T>.deserializeFrom(json: JSON(data).description, designatedPath: path) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
    
    /// 转成数组模型
    ///
    /// - Parameters:
    ///   - type: 模型 Class
    ///   - path: 指定转换路径
    /// - Returns: 转换成功
    /// - Throws: 转换失败
    func mapArray<T: HandyJSON>(_ type: T.Type, _ path: String? = nil) throws -> [T] {
        
        guard let model = JSONDeserializer<T>.deserializeModelArrayFrom(json: JSON(data).description, designatedPath: path) else {
            throw MoyaError.jsonMapping(self)
        }
        return model.flatMap({$0})
    }
}

extension Array: HandyJSON{}
extension String: HandyJSON{}
extension Int: HandyJSON{}
