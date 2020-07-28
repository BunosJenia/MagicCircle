//
//  Enums.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/24/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import Foundation

enum ColorType: CaseIterable {
    case Red
    case Orange
    case Blue
    case Green
    case Yellow
    case Purple
}

enum GameState {
    case preGame
    case inGame
    case afterGame
}

enum HUDSettings {
    static let score = "Score"
    static let highscore = "Highscore"
    static let gameOver = "Game Over"
    static let restart = "Restart"
    static let tapToStart = "Tap To Start"
    static let gameName = "Magic Circle"
    static let startGame = "Play"
}
