//
//  ClassScheduleModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/17.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

/// 課程Model
class ClassScheduleModel:Object, Mappable {
    @objc dynamic var id: String = ""
    let weak = RealmOptional<Int>()
    let unit = RealmOptional<Int>()
    @objc dynamic var cours: CoursModel?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        weak.value <- map["weak"]
        unit.value <- map["unit"]
        cours <- map["cours"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
