//
//  InterfaceController.swift
//  AdvanceNavigation WatchKit Extension
//
//  Created by Stuart Grimshaw on 21/12/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation

let duration = 2.0

class InterfaceController: WKInterfaceController {

    @IBOutlet var firstGroup: WKInterfaceGroup!
    @IBOutlet var secondGroup: WKInterfaceGroup!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        secondGroup.setRelativeWidth(0.0, withAdjustment: 0.0)
    }

    @IBAction func firstGroupButtonTapped() {
        animateWithDuration(duration, animations: {
            self.firstGroup.setRelativeWidth(0.0, withAdjustment: 0.0)
            self.secondGroup.setRelativeWidth(1.0, withAdjustment: 0.0)
        })
    }
    
    @IBAction func secondGroupButtonTapped() {
        animateWithDuration(duration, animations: {
            self.firstGroup.setRelativeWidth(1.0, withAdjustment: 0.0)
            self.secondGroup.setRelativeWidth(0.0, withAdjustment: 0.0)
        })
    }

}
