//
//  InterfaceController.swift
//  C-Quence WatchKit Extension
//
//  Created by Stuart Grimshaw on 6/09/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation

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
    var timer = NSTimer()
    
    override func awakeWithContext(context: AnyObject?) {
    }
    
    @IBAction func playButtonTapped() {
    }
    
    func startNewGame() {
    }
    
    func playSequence(){
    }
    
    func flashColor(color: Color, duration: Double) {
    }
    
    func timerFired() {
    }
    
    @IBAction func redButtonTapped() {
    }
    @IBAction func yellowButtonTapped() {
    }
    @IBAction func blueButtonTapped() {
    }
    @IBAction func greenButtonTapped() {
    }
    
    func colorButtonTapped(color: Color) {
    }
    
    func endGame(result: Int){
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
