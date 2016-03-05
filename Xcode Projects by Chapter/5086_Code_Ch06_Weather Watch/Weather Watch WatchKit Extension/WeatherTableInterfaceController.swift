//
//  WeatherTableInterfaceController.swift
//  Weather Watch
//
//  Created by Stuart Grimshaw on 7/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation


class WeatherTableInterfaceController: WKInterfaceController {
    
    @IBOutlet var weatherTable: WKInterfaceTable!
    var weatherDataArray: jsonArray = []

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        guard let data = context as? jsonDict else { print("Data is not json dictionary"); return }
        guard let list = data["list"] as? jsonArray else { print("No list data found"); return }
        weatherDataArray = list
        let basicWeatherData = extractBasicWeatherData(list)
        loadTableData(basicWeatherData)    }
    
    func extractBasicWeatherData(data: jsonArray) -> WeatherData {
        var tableDataArray: WeatherData = []
        for entry in data {
            if let
                name = entry["name"] as? String,
                weather = entry["weather"] as? jsonArray,
                summary = weather[0]["main"] as? String {
                    let basicEntry = WeatherSummary(cityName: name, summary: summary)
                    tableDataArray += [basicEntry]
            }
        }
        return tableDataArray
    }
    
    func loadTableData(data: WeatherData) {
        weatherTable.setNumberOfRows(data.count, withRowType: "TableRowControllerID")
        for (index, summary) in data.enumerate() {
            if let row = weatherTable.rowControllerAtIndex(index) as? WeatherTableRow {
                row.upperLabel.setText(summary.cityName)
                row.lowerLabel.setText(summary.summary)
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("DetailsInterface", context: weatherDataArray[rowIndex])
    }

}
