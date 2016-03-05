//
//  GlanceController.swift
//  Weather Watch WatchKit Extension
//
//  Created by Stuart Grimshaw on 6/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation

class GlanceController: WKInterfaceController {

    @IBOutlet var topLabel: WKInterfaceLabel!
    @IBOutlet var bottomLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        requestWeatherData()
    }
    
    func requestWeatherData() {
        WeatherSessionManager.sharedInstance.fetchWeatherData(){ (data: NSData?, response: NSURLResponse?, taskError: NSError?) in
            
            if taskError == nil {
                do {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! jsonDict
                    self.showWeather(jsonData)
                }
                catch let jsonError as NSError {
                    print(jsonError.localizedDescription)
                }
            }
            else {
                let action = WKAlertAction(title: "OK", style: .Default, handler: {})
                let alertText = taskError!.localizedDescription
                self.presentAlertControllerWithTitle(
                    alertText,
                    message: "",
                    preferredStyle: .ActionSheet,
                    actions: [action])
            }
        }
    }
    
    func showWeather(data: jsonDict) {
        guard let list = data["list"] as? jsonArray else {return }
        if let
            cityName = list[0]["name"] as? String,
            weather = list[0]["weather"] as? jsonArray,
            descriptionStr = weather[0]["main"] as? String {
                topLabel.setText(cityName)
                bottomLabel.setText(descriptionStr)
        }
    }

}
