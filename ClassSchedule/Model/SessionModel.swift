//
//  SessionModel.swift
//  ClassSchedule
//
//  Created by User on 2019/1/9.
//  Copyright © 2019 BIRC. All rights reserved.
//

import Foundation

/// 節次Model
struct SessionModel: Codable {
    
    var sessionNo: String? = nil
    var startTime: String? = nil
    var endTime: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case sessionNo = "class_no"
        case startTime = "start_at"
        case endTime = "end_at"
    }
    
}
