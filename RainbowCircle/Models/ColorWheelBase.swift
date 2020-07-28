//
//  Circle.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/28/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class ColorWheelBase: SKShapeNode {
    override init() {
        super.init()
        
        fillColor = UIColor.clear
        strokeColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSides(scene: SKScene, isLabel: Bool = false) {
        position = CGPoint(x: scene.size.width / 2, y: scene.size.height * self.getWheelYPositionOffset(isLabel: isLabel))
        
        let baseYPosition = scene.size.height * self.getSideYPositionOffset(isLabel: isLabel)
        let basePosition = CGPoint(x: scene.size.width / 2, y: baseYPosition)
        let sideHalfWidth = CGFloat.getThirtyDegreeTanValue(baseYPosition - position.y)

        for colorType in colorWheelSet {
            let side = Side(colorType: colorType, basePosition: basePosition, width: sideHalfWidth)
            side.position = side.convert(basePosition, to: self)
            side.zRotation -= zRotation

            self.addChild(side)

            self.zRotation += CGFloat.degreesToRadians(degrees: 60)
        }
    }
    
    func getWheelYPositionOffset(isLabel: Bool) ->CGFloat {
        return isLabel ? 0.5 : 0.25
    }
    
    func getSideYPositionOffset(isLabel: Bool) ->CGFloat {
        return isLabel ? 0.65 : 0.4
    }
    
    func rotate(_ toLeft: Bool = true) {
        var angle = CGFloat.degreesToRadians(degrees: 60)
        
        if toLeft == false {
            angle = -CGFloat.degreesToRadians(degrees: 60)
        }
        
        self.run(.rotate(byAngle: angle, duration: 0.3))
    }
}
