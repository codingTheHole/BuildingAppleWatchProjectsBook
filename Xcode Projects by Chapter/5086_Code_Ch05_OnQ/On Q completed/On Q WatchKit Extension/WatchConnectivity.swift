//
//  WatchConnectivity.swift
//  On Q
//
//  Created by Stuart Grimshaw on 17/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchConnectivityManager()
    
    let dataManager = WatchDataManager.sharedManager
    
    private override init() {
    super.init()
    if WCSession.isSupported() {
    let session = WCSession.defaultSession()
    session.delegate = self
    session.activateSession()
    }
}


    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        if let prompts = applicationContext[kPromptsKey] as! [Prompt]? {
            WatchDataManager.sharedManager.updatePrompts(prompts)
        }
    }
    
}
