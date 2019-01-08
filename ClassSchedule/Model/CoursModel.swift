//
//  CoursModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/16.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import ObjectMapper

/// 科目Model
struct CoursModel: Mappable, Codable{
    var name: String? = nil
    var teacher: String? = nil
    var room: String? = nil
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        teacher <- map["teacher"]
        room <- map["room"]
    }

}


