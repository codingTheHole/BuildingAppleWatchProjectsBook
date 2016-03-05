//
//  InterfaceController.swift
//  Plot Buddy WatchKit Extension
//
//  Created by Stuart Grimshaw on 23/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit

let kStartPlotting = "Start\nPlotting"
let kStopPlotting = "Stop\nPlotting"
let kStoreCoordinates = "Add Current\nCoordinates"
let kFetching = "Fetching Location..."
let kLocationFailed = "Location Failed"

class InterfaceController: WKInterfaceController, PBLocationManagerDelegate {
    
    var locationManager: PBLocationManager!
    var isRecording = false
    
    @IBOutlet var startStopGroup: WKInterfaceGroup!
    @IBOutlet var addPlotGroup: WKInterfaceGroup!
    @IBOutlet var showPlotsGroup: WKInterfaceGroup!
    @IBOutlet var showPlotsButton: WKInterfaceButton!
    @IBOutlet var infoLable: WKInterfaceLabel!
    @IBOutlet var startStopButton: WKInterfaceButton!
    @IBOutlet var addPlotButton: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        locationManager = PBLocationManager(delegate: self)
        updateUI(running: false)
    }
    
    @IBAction func startStopButtonPressed() {
        toggleRecording()
    }
    @IBAction func addPlotButtonPressed() {
        fetchLocation()
    }
    
    @IBAction func showPlotsButtonTapped() {
        pushControllerWithName("PlotsScene", context: locationManager.currentLocations)
    }

    @IBAction func sendPlotsButtonTapped() {
        WatchConnectivityManager.sharedManager.sendDataToWatch(
            locationManager.currentLocations)
    }
    
    func toggleRecording() {
        isRecording = !isRecording
        if isRecording {
            locationManager.clearLocations()
        }
        updateUI(running: isRecording)
    }
    
    func fetchLocation() {
        updateUI(fetching: true)
        locationManager.requestLocation()
    }
    
    func handleNewLocation(newLocation: CLLocation) {
        addPlotButton.setTitle(kStoreCoordinates)
        infoLable.setText("Lat:\n" + "\(newLocation.coordinate.latitude)" + "\nLong:\n" + "\(newLocation.coordinate.longitude)")
        updateUI(fetching: false)
    }
    
    func handleLocationFailure(error: NSError) {
        infoLable.setText(kLocationFailed)
        updateUI(fetching: false)
    }
    
    func updateUI(running running: Bool) {
        
        infoLable.setText("")
        infoLable.setHidden(!running)
        startStopButton.setTitle(isRecording ? kStopPlotting : kStartPlotting)
        
        showPlotsGroup.setHidden(running)
        showPlotsButton.setEnabled(locationManager.currentLocations.count > 0)
        showPlotsGroup.setBackgroundColor(locationManager.currentLocations.count > 0 ? UIColor.blueColor() : UIColor.clearColor())
        
        addPlotGroup.setHidden(!isRecording)
    }
    
    func updateUI(fetching fetching: Bool) {
        infoLable.setHidden(fetching)
        
        startStopButton.setEnabled(!fetching)
        startStopGroup.setBackgroundColor(fetching ? UIColor.clearColor() : UIColor.blueColor())
        
        addPlotButton.setEnabled(!fetching)
        addPlotGroup.setBackgroundColor(fetching ? UIColor.clearColor() : UIColor.blueColor())
        addPlotButton.setTitle(fetching ? kFetching : kStoreCoordinates)
    }
    
}
