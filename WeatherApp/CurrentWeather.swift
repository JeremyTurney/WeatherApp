//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Jeremy Turney on 10/17/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import Foundation
import Alamofire


class CurrentWeather
{
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemperature:Double!
    var _countryName:String!
   
    
    var cityName: String
    {
        if _cityName == nil
        {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String
    {
        if _date == nil
        {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
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
    
    var currentTemperature:Double
    {
        if _currentTemperature == nil
        {
            _currentTemperature = 0.0
        }
        
        return _currentTemperature
    }
    
    var countryName: String
    {
        if _countryName == nil
        {
            _countryName = ""
        }
        
        return _countryName.uppercased()
    }
    
    var cityCountryName:String
    {
        
        return "\(cityName), \(countryName)"
        
    }


    
    func downloadWeatherDetails(completed: @escaping DownloadComplete)
    {
        Alamofire.request(currentWeatherURL).responseJSON
        {
            response in let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                    print("HERE I AM\(self._cityName)")

                }
                if let system = dict["sys"] as? Dictionary<String, AnyObject>
                {

                    if let country = system["country"] as? String
                    {
                        self._countryName = country.capitalized
                        print("HERE I AM\(self._cityName)")
                    }
                }

                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]
                {
                    if let main = weather [0]["main"] as? String
                    {
                        self._weatherType = main
                        print("HERE I AM\(self._weatherType)")
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>
                {
                    if let currentTemperature = main["temp"] as? Double
                    {
                        let kelvinToFerenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                        
                        let kelvinToFerenheit = Double(round(10 * kelvinToFerenheitPreDivision/10))
                        
                        self._currentTemperature = kelvinToFerenheit
                        print("HERE I AM\(self._currentTemperature)")
                    }
                    
                }
            }
            completed()
        }
    }
    
    
}
