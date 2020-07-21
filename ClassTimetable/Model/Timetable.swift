//
//  Timetable.swift
//  ClassTimetable
//
//  Created by 謝佳瑋 on 2017/10/17.
//  Copyright © 2017年 NTUB. All rights reserved.
//

import Foundation

/// 課表
struct Timetable: Codable {

    var periods: [Period?]?
    var subjects: [[Subject?]]?

    private enum CodingKeys: String, CodingKey {
        case periods = "time"
        case subjects = "class"
    }

}
