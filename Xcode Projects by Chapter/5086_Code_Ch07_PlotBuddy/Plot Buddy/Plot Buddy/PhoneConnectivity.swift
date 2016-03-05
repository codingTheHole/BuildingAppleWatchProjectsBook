//
//  PhoneConnetivity.swift
//  On Q
//
//  Created by Stuart Grimshaw on 10/10/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchConnectivity

let kLocationDataKey = "Location Data"

class PhoneConnectivityManager: NSObject, WCSessionDelegate {
    static let sharedManager = PhoneConnectivityManager()
    private override init() {
        super.init()
        if WCSession.isSupported(){
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print(applicationContext)
    }
}