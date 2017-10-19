//
//  CoursModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/16.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

/// 科目Model
class CoursModel:Object, Mappable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String? = nil
    @objc dynamic var teacher: String? = nil
    @objc dynamic var room: String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        teacher <- map["teacher"]
        room <- map["room"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


