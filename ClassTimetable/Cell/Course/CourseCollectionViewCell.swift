//
//  CourseCollectionViewCell.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/11.
//  Copyright © 2017年 NTUB. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var room: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        name.text = ""
        teacher.text = ""
        room.text = ""

        layer.borderColor = UIColor.primaryLight.cgColor
        layer.borderWidth = 0.5
    }

}
