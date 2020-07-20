//
//  SessionModel.swift
//  ClassSchedule
//
//  Created by Billy on 2019/1/9.
//  Copyright © 2019 NTUB. All rights reserved.
//

import Foundation

/// 節次Model
struct SessionModel: Codable {

    var sessionNo: String?
    var startTime: String?
    var endTime: String?

    private enum CodingKeys: String, CodingKey {
        case sessionNo = "class_no"
        case startTime = "start_at"
        case endTime = "end_at"
    }

}
