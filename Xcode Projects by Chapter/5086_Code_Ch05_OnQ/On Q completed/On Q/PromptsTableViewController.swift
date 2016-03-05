//
//  PromptsTableViewController.swift
//  On Q
//
//  Created by Stuart Grimshaw on 10/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import UIKit

class PromptsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .Add, target: self, action: "addPrompt")
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .Edit, target: self, action: "toggleEdit")
        self.navigationItem.setRightBarButtonItems(
            [addButton, editButton], animated: true)
        
        tableView.dataSource = PhoneDataManager.sharedManager
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func addPrompt() {
        performSegueWithIdentifier("segueToNewPromptView", sender: self)
    }
    
    func toggleEdit() {
        editing = !editing
    }
    
}