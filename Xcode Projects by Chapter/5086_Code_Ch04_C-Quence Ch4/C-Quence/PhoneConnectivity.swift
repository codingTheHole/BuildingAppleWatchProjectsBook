//
//  PhoneConnectivity.swift
//  C-Quence
//
//  Created by Stuart Grimshaw on 20/09/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import Foundation
import WatchConnectivity
import UIKit

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
    
    func sendNameToWatch(playerName: String) {
        if !WCSession.defaultSession().paired {
            print("No paired watch")
            return
        }
        if !WCSession.defaultSession().watchAppInstalled {
            print("Watch app not installed")
            return
        }
        do {
            let context = [kPlayerName: playerName]
            print("Sent \(playerName) in ApplicationContext")
            try WCSession.defaultSession().updateApplicationContext(context)
        } catch {
            print("sendNameToWatch: applicationContext update failed")
        }
    }
    
}