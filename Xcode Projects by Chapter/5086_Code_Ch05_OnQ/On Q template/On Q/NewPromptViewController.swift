//
//  NewPromptViewController.swift
//  On Q
//
//  Created by Stuart Grimshaw on 10/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import UIKit

let colors = [kWhite, kRed, kGreen]

class NewPromptViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var extendedTextView: UITextView!
    @IBOutlet weak var colorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        saveButton.enabled = false
        headerTextField.addTarget(self, action: "headerTextChanged", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func headerTextChanged() {
        saveButton.enabled = headerTextField.text?.characters.count > 0
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let selectedColorIndex = colorSegmentedControl.selectedSegmentIndex
        let newPrompt = [
            kPromptText: headerTextField.text!,
            kDetailsText: extendedTextView.text!,
            kColor: colors[selectedColorIndex]]
        PhoneDataManager.sharedManager.addPrompt(newPrompt)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}