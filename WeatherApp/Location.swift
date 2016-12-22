//
//  Location.swift
//  WeatherApp
//
//  Created by Jeremy Turney on 10/19/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import Foundation
import CoreLocation

class Location
{
    static var sharedInstance = Location()
    private init()
    {
        
    }
    
    var latitude:Double!
    var longitude:Double!
    
    
}
