//
//  CourseModel.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/17.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import Foundation

/// 課程Model
struct CourseModel: Codable {
    
    var week: Int
    var session: Int
    var subject: SubjectModel? = nil
    
}
