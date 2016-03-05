//
//  InterfaceController.swift
//  HelloWatch WatchKit Extension
//
//  Created by Stuart Grimshaw on 24/08/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation

let kRed    = "Red"
let kPurple = "Purple"
let kBlue   = "Blue"

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var helloButton: WKInterfaceButton!
    @IBOutlet var borderGroup: WKInterfaceGroup!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    @IBAction func helloButtonTapped(){
        presentColorOptionsToUser()
    }
    
    func presentColorOptionsToUser() {
        presentTextInputControllerWithSuggestions(
            [kRed, kPurple, kBlue],
            allowedInputMode: WKTextInputMode.Plain,
            completion:{(results: [AnyObject]?) -> Void in
                if let validResults = results,
                    let resultString = validResults[0] as? String
                {
                    self.helloButton.setTitle(resultString)
                    self.changeBorderColor(resultString)
                }
        })
    }
    
    func changeBorderColor(colorString: String) {
        let newColor: UIColor
        
        switch colorString {
        case kRed:
            newColor = UIColor.redColor()
        case kPurple:
            newColor = UIColor.purpleColor()
        case kBlue:
            newColor = UIColor.blueColor()
        default:
            return
        }
        
        animateWithDuration(2.5, animations: {
            self.borderGroup.setBackgroundColor(newColor)
        })
    }
}
