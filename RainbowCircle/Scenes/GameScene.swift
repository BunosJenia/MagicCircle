//
//  GameScene.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/22/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit
import GameplayKit

let colorWheelSet:[ColorType] = [
.Blue,
.Green,
.Yellow,
.Orange,
.Red,
.Purple
]
var gameScore = 0

class GameScene: SKScene {
    let colorWheelBase = ColorWheelBase()
    let hud = HUD()
    
    var currentGameState: GameState = GameState.preGame
    var ballSpeed: TimeInterval = 2.5
    var waitBeforeRunningNewBall: TimeInterval = 0.2
    
    let validSound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
    let wrongSound = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)
    
    let gameArea: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat
        
        switch UIScreen.main.nativeBounds.height {
        case 2688, 1792, 2436:
            maxAspectRatio = 2.16
        default:
            maxAspectRatio = 16 / 9
        }
        
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        gameScore = 0
        
        backgroundColor = UIColor.gray
        
        self.spawnNodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentGameState == GameState.preGame {
            startGame()
        } else if currentGameState == GameState.inGame {
            for touch in touches {
                colorWheelBase.rotate(touch.location(in: self).x < (self.size.width / 2))
            }
        }
    }
    
    func startGame() {
        spawnBall()
        
        self.hud.removeTapToStartLabel()
        
        currentGameState = GameState.inGame
    }
}

extension GameScene {
    func spawnNodes() {
        self.addChild(colorWheelBase)
        self.addChild(hud)
        
        self.colorWheelBase.setupSides(scene: self)
        self.hud.setupGameSceneLabels()
        
        self.colorWheelBase.alpha = 0
        self.colorWheelBase.run(.fadeIn(withDuration: 0.5))
    }
    
    func spawnBall() {
        let ball = Ball()
        
        ball.setupBall(self)
    }
    
    func addScoreAndSpawnBall() {
        gameScore += 1
        self.run(self.validSound)
        self.hud.updateScore(gameScore)
        self.increaseBallSpeed()
        
        self.spawnBall()
    }
    
    func increaseBallSpeed() {
        if gameScore % 5 == 0 {
            if self.ballSpeed != 1.8 {
                self.ballSpeed -= 0.1
                
                if self.ballSpeed == 1.8 {
                    print("Max Speed")
                } else {
                    print("Speed increased")
                }
            }
        }
        
        if gameScore % 10 == 0 && self.waitBeforeRunningNewBall != 0 {
            self.waitBeforeRunningNewBall -= 0.1
        }
    }
    
    func gameOver() {
        self.currentGameState = GameState.afterGame
        self.colorWheelBase.removeAllActions()
        
        HighscoreGenerator.sharedInstance.setHighscore(gameScore)
        
        self.run(self.wrongSound)
        self.run(.sequence([.wait(forDuration: 3), .run(changeScene)]))
    }
    
    func changeScene() {
        let sceneToMoveTo = GameOverScene(size: self.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        
        sceneToMoveTo.scaleMode = self.scaleMode
        
        self.view?.presentScene(sceneToMoveTo, transition: transition)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let ball: Ball
        let side: Side
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Ball {
            ball = contact.bodyA.node! as! Ball
            side = contact.bodyB.node! as! Side
        } else {
            ball = contact.bodyB.node! as! Ball
            side = contact.bodyA.node! as! Side
        }
        
        if ball.isActibe == true {
            checkMatch(ball: ball, side: side)
        }
    }
    
    func checkMatch(ball: Ball, side: Side) {
        if ball.colorType == side.colorType {
            ball.deleteBall()
                
            self.addScoreAndSpawnBall()
        } else {
            ball.deleteBall(true)
            
            self.gameOver()
        }
    }
}
