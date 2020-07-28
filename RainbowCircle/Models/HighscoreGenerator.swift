//
//  HighscoreGenerator.swift
//  RainbowCircle
//
//  Created by Yauheni Bunas on 7/27/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import Foundation


class HighscoreGenerator {
    static let sharedInstance = HighscoreGenerator()
    
    private init() {}
    
    static let keyHighscore = "magicCircleHighscore"
    
    func setHighscore(_ highscore: Int) {
        if highscore > self.getHighscore() {
            UserDefaults.standard.set(highscore, forKey: HighscoreGenerator.keyHighscore)
        }
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: HighscoreGenerator.keyHighscore)
    }
}
