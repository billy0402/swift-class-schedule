//
//  NetURL.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/14.
//  Copyright © 2017年 NTUB. All rights reserved.
//

import Foundation

struct NetURL {
    enum NetAddress:String {
        case local = "http://127.0.0.1:8000"
        case main = "https://ntub-class.herokuapp.com"
    }
    
    static func url(_ address:NetAddress)->URL{
        return URL(string: address.rawValue)!
    }
}
