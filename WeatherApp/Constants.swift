//
//  Constants.swift
//  WeatherApp
//
//  Created by Jeremy Turney on 10/17/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import Foundation
import Alamofire


let baseURL = "http://api.openweathermap.org/data/2.5/"
let weather = "weather?"
let dailyForcast = "forecast/daily?"
let days = "&cnt=10&mode=json"
let latitude = "lat="
let longitude = "&lon="
let appID = "&appid="
let appKey = "47e5189e341c3c30cbc8402a97794ac2"
var latNum: String = (String(Location.sharedInstance.latitude!))
var lonNum: String = (String(Location.sharedInstance.longitude!))

typealias DownloadComplete = () -> ()

let currentWeatherURL = "\(baseURL)\(weather)\(latitude)\(latNum)\(longitude)\(lonNum)\(appID)\(appKey)"

let forcastURL = "\(baseURL)\(dailyForcast)\(latitude)\(latNum)\(longitude)\(lonNum)\(days)\(appID)\(appKey)"
