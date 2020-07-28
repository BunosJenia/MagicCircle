//
//  Ball.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/24/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class Ball: SKShapeNode {
    var colorType: ColorType
    var isActibe: Bool = true
    
    override init() {
        colorType = ColorType.allCases.randomElement()!
        
        super.init()
        
        let rect = CGRect(x:-50,y:-50,width: 100,height: 100)
        
        path = CGPath(ellipseIn: rect, transform: nil)
        
        fillColor = UIColor.getColorFromColorType(colorType: self.colorType)
        strokeColor = UIColor.clear
        
        physicsBody = SKPhysicsBody(circleOfRadius: 50)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.Ball
        physicsBody!.collisionBitMask = PhysicsCategory.None
        physicsBody!.contactTestBitMask = PhysicsCategory.Side
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Ball {
    func setupBall(_ scene: GameScene) {
        position = CGPoint(x: scene.size.width / 2, y: scene.size.height + 50)
        
        scene.addChild(self)
        
        self.run(.sequence([.wait(forDuration: scene.waitBeforeRunningNewBall), .move(to: CGPoint(x: scene.size.width / 2, y:  scene.size.height * 0.2), duration: scene.ballSpeed), .removeFromParent()]))
    }
    
    func deleteBall(_ isEnd: Bool = false) {
        self.isActibe = false
        
        if isEnd == true {
            self.removeAllActions()
            
            self.run(.repeat(.sequence([.fadeOut(withDuration: 0.4), .fadeIn(withDuration: 0.4)]), count: 3))
        } else {
            self.run(.sequence([.scale(to: 0, duration: 0.3), .removeFromParent()]))
        }
        
    }
}
