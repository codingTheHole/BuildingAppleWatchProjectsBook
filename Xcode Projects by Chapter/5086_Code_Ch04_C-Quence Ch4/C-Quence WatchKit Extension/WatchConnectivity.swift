//
//  WatchConnectivity.swift
//  C-Quence
//
//  Created by Stuart Grimshaw on 20/09/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchConnectivityManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported(){
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        if let playerName = applicationContext[kPlayerName] as! String? { //1
            print("received \(playerName) message") //2
            NSUserDefaults.standardUserDefaults().setObject(playerName, forKey: kPlayerName) //3
        }
    }
    
}