//
//  NewPromptViewController.swift
//  On Q
//
//  Created by Stuart Grimshaw on 17/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit

class DetailsInterfaceController: WKInterfaceController {
    
    @IBOutlet var detailsLabel: WKInterfaceLabel!
    
    let dataManager = WatchDataManager.sharedManager
    
    override func willActivate() {
        if let newPrompt = dataManager.lastSelectedPrompt(){ //2
        detailsLabel.setText(newPrompt[kDetailsText])
    } else {
        detailsLabel.setText("Please load Prompts from your Phone")
        }
    }
    
    override func willDisappear() {
        detailsLabel.setText("") 
    }
}

