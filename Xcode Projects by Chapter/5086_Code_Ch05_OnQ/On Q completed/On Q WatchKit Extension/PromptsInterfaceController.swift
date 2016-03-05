//
//  PromptsTableViewController.swift
//  On Q
//
//  Created by Stuart Grimshaw on 17/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit

class PromptsInterfaceController: WKInterfaceController {
    
    @IBOutlet var startGroup: WKInterfaceGroup!
    @IBOutlet var loadPromptsLabel: WKInterfaceLabel!
    
    @IBOutlet var promptsGroup: WKInterfaceGroup!
    @IBOutlet var promptLabel: WKInterfaceLabel!
    @IBOutlet var currentPromptNumberLabel: WKInterfaceLabel!
    @IBOutlet var backwardButton: WKInterfaceButton!
    @IBOutlet var forwardButton: WKInterfaceButton!
    
    let dataManager = WatchDataManager.sharedManager
    var expectedDisappear: Bool = false
    var running: Bool = false
    
    @IBAction func startButtonTapped() {
        start()
    }
    @IBAction func forwardButtonTapped() {
        nextPrompt()
    }
    @IBAction func backwardButtonTapped() {
        previousPrompt()
    }
    @IBAction func menuStopButtonTapped() {
        running = false
        promptsGroup.setHidden(true)
        startGroup.setHidden(false)
    }
    
    override func willActivate() {
        if !expectedDisappear && running {
            nextPrompt()
        }
        expectedDisappear = false
    }
    
    override func willDisappear() {
            expectedDisappear = true
    }
    
    func start() {
        if dataManager.promptsCount() == 0 {
        loadPromptsLabel.setHidden(false)
    } else {
        startGroup.setHidden(true)
        loadPromptsLabel.setHidden(true)
        promptsGroup.setHidden(false)
        dataManager.reset()
        running = true
        nextPrompt()
        }
    }
    
    func nextPrompt() {
            if let newPrompt = dataManager.nextPrompt(){
            updateUIForPrompt(newPrompt)
            }
    }
    func previousPrompt() {
            if let newPrompt = dataManager.previousPrompt(){
            updateUIForPrompt(newPrompt)
            }
    }
    
    func updateUIForPrompt(newPrompt: Prompt) {
            if let promptText = newPrompt[kPromptText] {
            promptLabel.setText(promptText)
            }
            if let promptColor = newPrompt[kColor] {
            promptLabel.setTextColor(globalColors[promptColor])
            }
            updateButtonStates()
    }
    
    func updateButtonStates() {
        forwardButton.setEnabled(!dataManager.isLastPrompt())
        backwardButton.setEnabled(!dataManager.isFirstPrompt())
            
        if dataManager.lastSelectedPromptIndex() >= 0 {
            currentPromptNumberLabel.setHidden(false)
            currentPromptNumberLabel.setText(
                "\(dataManager.lastSelectedPromptIndex() + 1) of \(dataManager.promptsCount()) ")
        } else {
            currentPromptNumberLabel.setHidden(true)
        }
    }
    
}