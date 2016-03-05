//
//  PlotSceneInterfaceController.swift
//  Plot Buddy
//
//  Created by Stuart Grimshaw on 24/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit

class TableRowController: NSObject {
    @IBOutlet var label: WKInterfaceLabel!
}

class PlotsSceneInterfaceController: WKInterfaceController {
    
    @IBOutlet var plotsTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let data = context as? LocationSet {
            loadTable(data)
        }
    }
    
    func loadTable(data: LocationSet) {
        plotsTable.setNumberOfRows(data.count, withRowType: "TableRowControllerID")
        for (index, location) in data.enumerate() {
            if let row = plotsTable.rowControllerAtIndex(index) as? TableRowController {
                row.label.setText(
                    "Location \(index + 1)\n" +
                    "Lat: \(location.coordinate.latitude)\n" +
                    "Lon: \(location.coordinate.longitude)"
                )
            }
        }
    }
}