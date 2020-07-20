//
//  UIColor+Custom.swift
//  ClassSchedule
//
//  Created by 謝佳瑋 on 2018/9/15.
//  Copyright © 2018年 NTUB. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(netHex: Int, alpha: CGFloat = 1.0) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff, alpha: alpha)
    }

    static let primary = UIColor(netHex: 0x43F3E87)
    static let secondary = UIColor(netHex: 0xDEBC93)
    static let primaryLight = UIColor(netHex: 0x7A94B1)
    static let secondaryLight = UIColor(netHex: 0xFAEBD7)
    static let secondaryDark = UIColor(netHex: 0xE3D1BB)
}
