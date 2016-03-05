//
//  SessioManager.swift
//  Weather Watch
//
//  Created by Stuart Grimshaw on 6/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import Foundation

let baseUrl     = "http://api.openweathermap.org/data/2.5/group?units=metric"
let APIKey      = "78c75588dfe58276a694af9c660ed39d"
let faveCity    = 2643741
let cities  = [faveCity, 2193733, 1273294, 5128581, 2950159, 3435910]

/* For a list of city codes, see:
http://openweathermap.org/help/city_list.txt
*/

class WeatherSessionManager {
    
    static let sharedInstance = WeatherSessionManager()
    private init() {}
    
    var lastRequestDate: NSDate?
    
    func urlForCities(cityCodes: [Int]) -> String {
        var urlStr = baseUrl + "&APPID=" + APIKey + "&id="
        for cityCode in cityCodes {
            urlStr += "\(cityCode),"
        }
        return urlStr
    }
    
    typealias DataTaskCompletionHandler =
        (NSData?, NSURLResponse?, NSError?) -> Void
    
    func fetchWeatherData(completionHandler: DataTaskCompletionHandler) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        if let date = lastRequestDate
            where NSDate().timeIntervalSinceDate(date)  < 10.0 {
                sessionConfig.requestCachePolicy = .ReturnCacheDataElseLoad
        } else {
            sessionConfig.requestCachePolicy = .UseProtocolCachePolicy
        }
        lastRequestDate = NSDate()
        let session = NSURLSession(configuration: sessionConfig)
        let apiCall = urlForCities(cities)
        if let url = NSURL(string: apiCall) {
            let task = session.dataTaskWithURL(url, completionHandler: completionHandler)
            task.resume()
        }
    }
    
}