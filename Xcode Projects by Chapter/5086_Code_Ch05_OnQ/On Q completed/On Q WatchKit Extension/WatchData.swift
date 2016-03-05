//
//  WatchData.swift
//  On Q
//
//  Created by Stuart Grimshaw on 17/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit

let kPromptsArchive = "promptsArchive"

class WatchDataManager {
    
    static let sharedManager = WatchDataManager()
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask).first!
    static let PromptsArchive = DocumentsDirectory.URLByAppendingPathComponent(kPromptsArchive)
    
    private var currentPromptIndex = -1
    private var prompts: [Prompt] = []
    
    private init(){
        if let storedPrompts = NSUserDefaults.standardUserDefaults().objectForKey(kPromptsKey) as! [Prompt]? {
        self.prompts = storedPrompts
        }
    }
    func nextPrompt() -> Prompt? {
        if currentPromptIndex >= prompts.count - 1 {
        return nil
    } else {
        currentPromptIndex += 1
        return prompts[currentPromptIndex]
        }
    }
    func previousPrompt() -> Prompt? {
        if currentPromptIndex <= 0 {
        return nil
    } else {
        currentPromptIndex -= 1
        return prompts[currentPromptIndex]
        }
    }
    func isFirstPrompt() -> Bool {
        return currentPromptIndex <= 0
    }
    func isLastPrompt() -> Bool {
        return currentPromptIndex >= prompts.count - 1
    }
    func lastSelectedPrompt() -> Prompt? {
        if currentPromptIndex >= 0 && currentPromptIndex < prompts.count {
        return prompts[currentPromptIndex]
    } else {
        return nil
        }
    }
    func lastSelectedPromptIndex() -> Int {
        return currentPromptIndex
    }
    func promptsCount() -> Int {
        return prompts.count
    }
    func updatePrompts(prompts: [Prompt]) {
        NSUserDefaults.standardUserDefaults().setObject(prompts, forKey: kPromptsKey)
        self.prompts = prompts
        WKInterfaceDevice.currentDevice().playHaptic(.Success)
    }
    func reset() {
        currentPromptIndex = -1
    }
}
