//
//  Side.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/24/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class Side: SKShapeNode {
    let yOffset: CGFloat = 35
    let xOffset: CGFloat
    
    var colorType: ColorType
    
    init(colorType: ColorType, basePosition: CGPoint, width: CGFloat) {
        self.colorType = colorType
        self.xOffset = CGFloat.getThirtyDegreeTanValue(yOffset)
        
        super.init()
        
        let shapePath = self.drawTrapezoid(basePosition: basePosition, width: width)

        path = shapePath.cgPath
        zPosition = 1
        fillColor = UIColor.getColorFromColorType(colorType: self.colorType)
        strokeColor = UIColor.clear
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: -width - self.xOffset, y: 0), size: frame.size))
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.Side
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Ball
    }
    
    func drawTrapezoid(basePosition: CGPoint, width: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint())
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width + self.xOffset, y: self.yOffset))
        path.addLine(to: CGPoint(x: -width - self.xOffset, y: self.yOffset))
        path.addLine(to: CGPoint(x: -width, y: 0))
        path.addLine(to: CGPoint())
        path.close()
        
        return path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
