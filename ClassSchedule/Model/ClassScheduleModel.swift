//
//  ClassScheduleModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/17.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import ObjectMapper

/// 課程Model
struct ClassScheduleModel: Mappable, Codable {
    
    var id: String = ""
    var week = 0
    var unit = 0
    var cours: CoursModel? = nil
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        week <- map["weak"]
        unit <- map["unit"]
        cours <- map["cours"]
    }
}
