//
//  HUD.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/26/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit


class HUD: SKNode {
    var fontNamed = "Spaceman"

    var scoreLabel: SKLabelNode!
    var highscoreLabel: SKLabelNode!
    var tapToStartLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    var restartLabel: SKLabelNode!
    var gameNameLabel: SKLabelNode!
    var startGameLabel: SKLabelNode!

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel(_ name: String, fontSize: CGFloat, position: CGPoint) {
        let label = SKLabelNode()
        
        //label.fontName = fontNamed
        label.name = name
        label.text = name
        label.position = position
        label.fontSize = fontSize
        label.zPosition = 5
        
        addChild(label)
    }
    
    func setupTapToStartLabel() {
        guard let scene = scene as? GameScene else { return }

        addLabel(HUDSettings.tapToStart, fontSize: 70, position: CGPoint(x: scene.size.width / 2, y: scene.size.height / 2))

        tapToStartLabel = childNode(withName: HUDSettings.tapToStart) as? SKLabelNode

        self.showLabels(tapToStartLabel)
    }
    
    func removeTapToStartLabel() {
        tapToStartLabel.run(.sequence([.fadeOut(withDuration: 0.3), .removeFromParent()]))
    }
    
    func setupScoreLabel(_ score: Int = 0) {
        guard let scene = scene as? GameScene else { return }
        
        let position = CGPoint(x: scene.gameArea.minX + 50, y: scene.size.height * 0.95)
        
        addLabel(HUDSettings.score, fontSize: 40, position: position)
        
        scoreLabel = childNode(withName: HUDSettings.score) as? SKLabelNode
        
        scoreLabel.text = "Score: \(score)"

        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.verticalAlignmentMode = .top
        
        showLabels(scoreLabel)
    }
    
    func setupHighscoreLabel(_ score: Int) {
        guard let scene = scene as? GameScene else { return }
        
        let position = CGPoint(x: scene.gameArea.maxX - 50, y: scene.size.height * 0.95)
        
        addLabel(HUDSettings.highscore, fontSize: 40, position: position)
        
        highscoreLabel = childNode(withName: HUDSettings.highscore) as? SKLabelNode
        highscoreLabel.text = "Highscore: \(HighscoreGenerator.sharedInstance.getHighscore())"
        
        highscoreLabel.horizontalAlignmentMode = .right
        highscoreLabel.verticalAlignmentMode = .top
        
        showLabels(highscoreLabel)
    }
    
    func updateScore(_ score: Int) {
        scoreLabel = childNode(withName: HUDSettings.score) as? SKLabelNode
        
        scoreLabel.text = "Score: \(score)"
    }
    
    func showLabels(_ label: SKLabelNode) {
        label.alpha = 0
        label.run(.fadeIn(withDuration: 0.5))
    }
    
    func setupGameOverLabel() {
        guard let scene = scene as? GameOverScene else { return }

        let gameoverLabelPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.5)
        let scoreLabelPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.75)
        let highscoreLabelPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.8)
        let restartLabelPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.2)

        addLabel(HUDSettings.gameOver, fontSize: 90, position: gameoverLabelPosition)
        addLabel(HUDSettings.score, fontSize: 80, position: scoreLabelPosition)
        addLabel(HUDSettings.highscore,  fontSize: 80, position: highscoreLabelPosition)
        addLabel(HUDSettings.restart, fontSize: 60, position: restartLabelPosition)

        
        gameOverLabel = childNode(withName: HUDSettings.gameOver) as? SKLabelNode
        scoreLabel = childNode(withName: HUDSettings.score) as? SKLabelNode
        highscoreLabel = childNode(withName: HUDSettings.highscore) as? SKLabelNode
        restartLabel = childNode(withName: HUDSettings.restart) as? SKLabelNode
        
        highscoreLabel.text = "Highscore: \(HighscoreGenerator.sharedInstance.getHighscore())"
        scoreLabel.text = "Score: \(gameScore)"
    }
    
    func setupMainMenuLabel() {
        guard let scene = scene as? MainMenuScene else { return }
               
        let gameNameLabelPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.5)
        let startGameLabelPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.25)


        addLabel(HUDSettings.gameName, fontSize: 70, position: gameNameLabelPosition)
        addLabel(HUDSettings.startGame, fontSize: 70, position: startGameLabelPosition)


        gameNameLabel = childNode(withName: HUDSettings.gameName) as? SKLabelNode
        startGameLabel = childNode(withName: HUDSettings.startGame) as? SKLabelNode
    }
    
    func setupGameSceneLabels() {
        self.setupTapToStartLabel()
        self.setupScoreLabel()
        self.setupHighscoreLabel(HighscoreGenerator.sharedInstance.getHighscore())
    }
}
