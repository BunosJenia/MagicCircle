//
//  MainMenuScene.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/28/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    let hud = HUD()
    let colorWheelBase = ColorWheelBase()
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.gray
        
        self.addChild(hud)
        self.addChild(colorWheelBase)
        
        colorWheelBase.setupSides(scene: self, isLabel: true)
        hud.setupMainMenuLabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            let sceneToMoveTo = GameScene(size: self.size)
            let transition = SKTransition.fade(withDuration: 0.5)
            
            sceneToMoveTo.scaleMode = self.scaleMode
             
            self.view?.presentScene(sceneToMoveTo, transition: transition)
        }
    }
}
