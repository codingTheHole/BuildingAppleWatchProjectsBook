//
//  ShareConstants.swift
//  On Q
//
//  Created by Stuart Grimshaw on 10/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import UIKit

typealias Prompt = [String: String]

let kPromptsKey     = "Prompts"
let kPromptText     = "headerText"
let kDetailsText    = "extendedText"
let kColor          = "color"

let kWhite  = "White"
let kRed    = "Red"
let kGreen  = "Green"

let globalColors = [
    kWhite: UIColor.whiteColor(),
    kRed: UIColor.redColor(),
    kGreen: UIColor(red: 0.3, green: 1.0, blue: 0.3, alpha: 1.0)
]