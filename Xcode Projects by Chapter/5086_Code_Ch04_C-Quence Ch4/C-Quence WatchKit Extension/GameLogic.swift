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
    var nextAnswerIndex = 0
    
    func extendSequence() {
        let randomInt = Int(arc4random_uniform(4))
        let nextColor: Color =
        [.Red, .Yellow, .Blue, .Green][randomInt]
        sequence += [nextColor]
    }
    
    func evaluateColor(color: Color) -> GuessResult {
        if color != sequence[nextAnswerIndex] {
            return .GuessWrong
        } else {
            if nextAnswerIndex < sequence.count - 1 {
            nextAnswerIndex++
            return .GuessCorrect
        } else {
            nextAnswerIndex = 0
            return .GuessComplete
            }
        }
    }
    
    func clearGame() {
        sequence = []
        nextAnswerIndex = 0
    }
}