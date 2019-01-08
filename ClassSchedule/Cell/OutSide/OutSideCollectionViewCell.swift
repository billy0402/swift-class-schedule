//
//  OutSideCollectionViewCell.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2017/10/13.
//  Copyright © 2017年 BIRC. All rights reserved.
//

import UIKit

class OutSideCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var item: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        item.text = ""
        layer.borderColor = UIColor.primaryLight.cgColor
        layer.borderWidth = 0.5
    }

}
