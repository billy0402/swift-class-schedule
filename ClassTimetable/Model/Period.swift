//
//  Period.swift
//  ClassTimetable
//
//  Created by Billy on 2019/1/9.
//  Copyright © 2019 NTUB. All rights reserved.
//

import Foundation

/// 節次
struct Period: Codable {

    var periodNo: String?
    var startTime: String?
    var endTime: String?

    private enum CodingKeys: String, CodingKey {
        case periodNo = "class_no"
        case startTime = "start_at"
        case endTime = "end_at"
    }

}
