//
//  CGFloat.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/24/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

extension CGFloat {
    static func getThirtyDegreeTanValue(_ value: CGFloat) -> CGFloat {
        return value * sqrt(3) / 3
    }
    
    static func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * 0.0174533
    }
}
