//
//  Forcast.swift
//  WeatherApp
//
//  Created by Jeremy Turney on 10/18/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import UIKit
import Alamofire

class Forcast
{
    var _date:String!
    var _weatherType:String!
    var _lowTemp:Double!
    var _highTemp:Double!
    
    
    var date: String
    {
        if _date == nil
        {
            _date = ""
        }
        
        return _date
    }

    var weatherType: String
    {
        if _weatherType == nil
        {
            _weatherType = ""
        }
        
        return _weatherType
    }

    var lowTemp:Double
    {
        if _lowTemp == nil
        {
            _lowTemp = 0.0
        }
        
        return _lowTemp
    }

    var highTemp:Double
    {
        if _highTemp == nil
        {
            _highTemp = 0.0
        }
        
        return _highTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>)
    {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>
        {
            if let min = temp["min"] as? Double
            {
                let kelvinToFerenheitPreDivision = (min * (9/5) - 459.67)
                
                let kelvinToFerenheit = Double(round(10 * kelvinToFerenheitPreDivision/10))
                
                self._lowTemp = kelvinToFerenheit
            }
            if let max = temp["max"] as? Double
            {
                let kelvinToFerenheitPreDivision = (max * (9/5) - 459.67)
                
                let kelvinToFerenheit = Double(round(10 * kelvinToFerenheitPreDivision/10))
                
                self._highTemp = kelvinToFerenheit
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]
        {
            if let main = weather[0]["main"] as? String
            {
                self._weatherType = main
              
            }
            
            if let date = weatherDict["dt"] as? Double
            {
                let unixCovertDate = Date(timeIntervalSinceNow: date)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                dateFormatter.dateFormat = "EEEE"
                dateFormatter.timeStyle = .none
                self._date = String(unixCovertDate.dayOfTheWeek())
            }
        }
    }
    
}
    
extension Date
{
    func dayOfTheWeek() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
    
    

