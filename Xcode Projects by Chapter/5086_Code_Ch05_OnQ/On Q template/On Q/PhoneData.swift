//
//  PhoneData.swift
//  On Q
//
//  Created by Stuart Grimshaw on 10/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import Foundation
import UIKit

class PhoneDataManager:NSObject, UITableViewDataSource {
    
    static let sharedManager = PhoneDataManager()
    
    var prompts: [Prompt] = [
        [kPromptText: "This is an example prompt", kDetailsText: "This is some example extra text", kColor: kRed],
    ]
    
    private override init() {
        if let storedPrompts = NSUserDefaults.standardUserDefaults().objectForKey(kPromptsKey) as! [Prompt]?
        {
            self.prompts = storedPrompts
        }
    }
    
    func addPrompt(prompt: Prompt) {
        prompts += [prompt]
        storePrompts()
    }
    
    func storePrompts() {
        NSUserDefaults.standardUserDefaults().setObject(prompts, forKey: kPromptsKey)
    }
    
    // MARK: TableViewDataSource methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellID")
        cell.textLabel?.text = prompts[indexPath.row][kPromptText]
        cell.detailTextLabel?.text = prompts[indexPath.row][kDetailsText]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prompts.count
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let prompt = prompts.removeAtIndex(sourceIndexPath.row)
        prompts.insert(prompt, atIndex: destinationIndexPath.row)
        storePrompts()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            prompts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            storePrompts()
        }
    }
}