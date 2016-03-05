//
//  InterfaceController.swift
//  C-Quence WatchKit Extension
//
//  Created by Stuart Grimshaw on 6/09/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation

let fadedColorAlpha: CGFloat    = 0.4
let flashColorAlpha: CGFloat    = 1.0
let longFlashDuration           = 0.8
let shortFlashDuration          = 0.3
let timerInterval               = 1.0

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var playButton: WKInterfaceButton!
    @IBOutlet var resultLabel: WKInterfaceLabel!
    
    @IBOutlet var gameboardGroup: WKInterfaceGroup!
    @IBOutlet var redGroup: WKInterfaceGroup!
    @IBOutlet var yellowGroup: WKInterfaceGroup!
    @IBOutlet var blueGroup: WKInterfaceGroup!
    @IBOutlet var greenGroup: WKInterfaceGroup!
    
    var gameLogic: GameLogic = GameLogic()
    var userInputEnabled = false
    var indexOfNextColorToFlash = 0
    var timer: NSTimer = NSTimer()
    var intervalFactor = 1.0

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        for group in [redGroup, yellowGroup, blueGroup, greenGroup]{
            group.setAlpha(fadedColorAlpha)
        }
    }
    
    @IBAction func playButtonTapped() {
        startNewGame()
    }
    
    func startNewGame() {
        gameboardGroup.setHidden(false)
        playButton.setHidden(true)
//        resultLabel.setHidden(true)
        playSequence()
    }
    
    func playSequence(){
        userInputEnabled = false
        indexOfNextColorToFlash = 0
        gameLogic.extendSequence()
        timer = NSTimer.scheduledTimerWithTimeInterval(
            timerInterval,
            target: self,
            selector: "timerFired",
            userInfo: nil,
            repeats: true)
    }
    
    func timerFired() {
        let colorToFlash =
        gameLogic.sequence[indexOfNextColorToFlash] //1
        flashColor(colorToFlash, duration: longFlashDuration) //2
        if indexOfNextColorToFlash < gameLogic.sequence.count - 1 //3
        {
            indexOfNextColorToFlash++
        } else {
            timer.invalidate() //4
            userInputEnabled = true
        }
    }
    
    func flashColor(color: Color, duration: Double) {
            let group: WKInterfaceGroup
            switch color{
        case .Red:
            group = redGroup
        case .Yellow:
            group = yellowGroup
        case .Blue:
            group = blueGroup
        case .Green:
            group = greenGroup
            }
            group.setAlpha(flashColorAlpha)
            animateWithDuration(duration) {
            group.setAlpha(fadedColorAlpha)
            }
    }
    

    
    @IBAction func redButtonTapped()    {
        colorButtonTapped(.Red)
    }
    @IBAction func yellowButtonTapped() {
        colorButtonTapped(.Yellow)
    }
    @IBAction func blueButtonTapped()   {
        colorButtonTapped(.Blue)
    }
    @IBAction func greenButtonTapped()  {
        colorButtonTapped(.Green)
    }
    
    func colorButtonTapped(color: Color) {
        if userInputEnabled {
            flashColor(color, duration: shortFlashDuration)
            let guessResult = gameLogic.evaluateColor(color)
            switch guessResult {
            case .GuessCorrect:
                break
            case .GuessWrong:
                endGame(gameLogic.sequence.count - 1)
            case .GuessComplete:
                playSequence()
            }
        }
    }
    
    func endGame(result: Int){
        gameboardGroup.setHidden(true)
        resultLabel.setHidden(false)
        
        let resultText = textForResult(result) // new
        resultLabel.setText(resultText)
        
        playButton.setHidden(false)
        playButton.setTitle("Play Again")
        gameLogic.clearGame()
    }
    
    func textForResult(result: Int) -> String {
        if let playerName = NSUserDefaults.standardUserDefaults().objectForKey(kPlayerName) as! String? {
            return "Hey \(playerName), you scored \(result)"
        } else {
            return "Not bad! You scored \(result)"
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
