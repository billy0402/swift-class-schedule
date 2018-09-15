//
//  APIManager.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/13.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import Moya

enum APIManager: TargetType {
    case getCourse(String)
}

extension APIManager {
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }
    
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

    var parameters: [String : AnyObject]? {
        switch self {
        default:
            return nil
        }
    }
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)! as Data
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
}

