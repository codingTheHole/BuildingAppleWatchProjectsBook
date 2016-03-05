//
//  ViewController.swift
//  C-Quence
//
//  Created by Stuart Grimshaw on 6/09/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNameButtonTapped(sender: AnyObject) {
        savePlayerName()
    }
    
    func savePlayerName() {
        if playerNameTextField.text != "" {
            PhoneConnectivityManager.sharedManager.sendNameToWatch(playerNameTextField.text!)
        }
        playerNameTextField.resignFirstResponder()
    }
    
}

