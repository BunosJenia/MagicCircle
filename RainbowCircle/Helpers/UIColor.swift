//
//  UIColor.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/24/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

extension UIColor {
    static func getColorFromColorType(colorType: ColorType) ->UIColor {
        switch colorType {
        case .Blue:
            return UIColor.blue
        case .Green:
            return UIColor.green
        case .Orange:
            return UIColor.orange
        case .Purple:
            return UIColor.purple
        case .Red:
            return UIColor.red
        case .Yellow:
            return UIColor.yellow
        }
    }
}
