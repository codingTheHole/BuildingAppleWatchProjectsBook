//
//  WatchConnectivity.swift
//  Plot Buddy
//
//  Created by Stuart Grimshaw on 24/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchConnectivityManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func sendDataToWatch(data: AnyObject) {
        guard let contextData = data as? LocationSet else {return}
        
        let dataArray = contextDataFrom(locationSet: contextData)
        let context = [kApplicationContextDataKey: dataArray]
        do {
            try WCSession.defaultSession().updateApplicationContext(context)
            print("updateApplicationContext succeeded")
        } catch {
            print("updateApplicationContext failed")
        }
    }
    
    func contextDataFrom(locationSet locationSet: LocationSet) -> [[String: String]] {
        var dataArray = [[String: String]]()
        
        for (index, location) in locationSet.enumerate() {
            let locationDict = [
                "index": "\(index)",
                "lat": "\(location.coordinate.latitude)",
                "lon": "\(location.coordinate.longitude)"
            ]
            dataArray += [locationDict]
        }
        return dataArray
    }
    
}