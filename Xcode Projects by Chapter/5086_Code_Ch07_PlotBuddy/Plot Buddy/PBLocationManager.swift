//
//  PBLOcationManager.swift
//  Plot Buddy
//
//  Created by Stuart Grimshaw on 23/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit

protocol PBLocationManagerDelegate {
    func handleNewLocation(newLocation: CLLocation)
    func handleLocationFailure(error: NSError)
}

class PBLocationManager: NSObject, CLLocationManagerDelegate
{
    let locationManager = CLLocationManager()
    var currentLocations = LocationSet()
    var delegate: PBLocationManagerDelegate
    
    init(delegate: PBLocationManagerDelegate) {
        self.delegate = delegate
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation()
    {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus {
        case .NotDetermined:
            print("requestLocation = NotDetermined")
        case .AuthorizedWhenInUse:
            locationManager.requestLocation()
        case .Denied:
            print("requestLocation = Denied")
        default:
            print("requestLocation = default")
        }
    }
    
    func clearLocations() {
        currentLocations = []
    }
    
    func locationManager(
        manager: CLLocationManager,
        didUpdateLocations locations: LocationSet) {
        currentLocations += [locations[0]]
        delegate.handleNewLocation(locations[0])
        
    }
    func locationManager(
        manager: CLLocationManager,
        didFailWithError error: NSError) {
        delegate.handleLocationFailure(error)
    }
    
}