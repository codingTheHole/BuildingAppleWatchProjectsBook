//
//  GameLogic.swift
//  C-Quence
//
//  Created by Stuart Grimshaw on 6/09/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import Foundation

enum Color {
    case Red, Yellow, Blue, Green
}
enum GuessResult {
    case GuessCorrect, GuessWrong, GuessComplete
}

class GameLogic {
    
    var sequence: [Color] = []
    
    func extendSequence(){
    }
    
    func evaluateColor(color: Color) -> GuessResult{
        return .GuessCorrect
    }
    
    func clearGame(){
    }
}