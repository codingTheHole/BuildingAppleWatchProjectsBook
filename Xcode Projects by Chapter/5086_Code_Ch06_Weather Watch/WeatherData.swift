//
//  WeatherData.swift
//  Weather Watch
//
//  Created by Stuart Grimshaw on 6/11/15.
//  Copyright © 2015 Stuart Grimshaw. All rights reserved.
//

import Foundation

struct WeatherSummary {
    let cityName: String
    let summary: String
    init(cityName: String, summary: String) {
        self.cityName = cityName
        self.summary = summary
    }
}

typealias WeatherData = [WeatherSummary]