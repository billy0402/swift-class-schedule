//
//  Course.swift
//  ClassTimetable
//
//  Created by 謝佳瑋 on 2017/10/17.
//  Copyright © 2017年 NTUB. All rights reserved.
//

import Foundation

/// 課程
struct Course: Codable {

    var week: Int
    var period: Int
    var subject: Subject?

}
