//
//  APIManager.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/13.
//  Copyright © 2017年 NTUB. All rights reserved.
//

import Moya

enum APIManager {
    case getCourse(String)
}

extension APIManager: TargetType {
    
    var baseURL: URL {
        return NetURL.url(.main)
    }
    
    var path: String {
        switch self {
        case .getCourse(let id):
            return "/personal/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String : AnyObject]? {
        switch self {
        default:
            return nil
        }
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
    
}
