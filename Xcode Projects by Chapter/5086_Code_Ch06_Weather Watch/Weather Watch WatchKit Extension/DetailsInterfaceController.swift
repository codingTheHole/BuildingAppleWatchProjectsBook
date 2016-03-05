//
//  DetailsInterfaceController.swift
//  Weather Watch
//
//  Created by Stuart Grimshaw on 9/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import WatchKit
import Foundation


class DetailsInterfaceController: WKInterfaceController {

    @IBOutlet var detailsLabel: WKInterfaceLabel!
    @IBOutlet var image: WKInterfaceImage!
    
    let imageBaseUrl = "http://openweathermap.org/img/w/"
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let data = context as? jsonDict {
            displayData(data)
        }
    }

    func displayData(data: jsonDict) {
        var detailsText = ""
        if let cityName = data["name"] as? String{
            detailsText += cityName + "\n"
        }
        
        if let main = data["main"] as? jsonDict {
            if let humidity = main["humidity"] as? Int {
                detailsText += "Humidity: \(humidity)\n"
            }
            if let temp = main["temp"] as? Int {
                detailsText += "Temp: \(temp)\n"
            }
        }
        
        if let
            wind = data["wind"] as? jsonDict,
            speed = wind["speed"] as? Double
        {
            detailsText += "Windspeed: \(speed) Km/h"
        }
        
        if let weather = data["weather"] as? jsonArray {
            if let icon = weather[0]["icon"] as? String {
                fetchIcon(icon)
            }
            if let descriptionStr = weather[0]["description"] as? String {
                detailsText += "Weather: " + descriptionStr + "\n"
            }
        }
        detailsLabel.setText(detailsText)
        
    }
    
    func fetchIcon(iconStr: String) {
        let imageUrlStr = imageBaseUrl + iconStr + ".png"
        
        if let imageUrl = (NSURL(string: imageUrlStr))
        {
            let sessionConfig
            = NSURLSessionConfiguration.defaultSessionConfiguration()
            sessionConfig.requestCachePolicy
                = .ReturnCacheDataElseLoad
            let session = NSURLSession(configuration: sessionConfig)
            let task = session.dataTaskWithURL(imageUrl)
                { (
                    data: NSData?,
                    response: NSURLResponse?,
                    error: NSError?) in
                    if let unwrappeData = data {
                        self.image.setImage(UIImage(
                            data: unwrappeData))
                    }
            }
            task.resume()
        }
    }

}
