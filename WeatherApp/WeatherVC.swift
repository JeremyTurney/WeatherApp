//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jeremy Turney on 10/14/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//
import Alamofire
import UIKit
import CoreLocation


class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate
{
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var CurrentWeatherConditionLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var weather: CurrentWeather!
    var forcast: Forcast!
    var forcasts = [Forcast]()
    let manager = CLLocationManager()
    var location: CLLocation!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startMonitoringSignificantLocationChanges()
        
        weather = CurrentWeather()
        //forcast = Forcast()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            location = manager.location
            Location.sharedInstance.longitude = location.coordinate.longitude
            Location.sharedInstance.latitude = location.coordinate.latitude
            //print("LOCATION:\(location.coordinate.longitude) \(location.coordinate.latitude)")
            weather.downloadWeatherDetails
                {
                    self.downloadForcast
                        {
                            self.updateMainUI()
                    }
            }

        }
        
        else
        {
            manager.requestWhenInUseAuthorization()
            locationAuthStatus()
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return forcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            let forcast = forcasts[indexPath.row]
            cell.configureCell(forcast: forcast)
            return cell
        }
        else
        {
            return WeatherCell()
        }
    }
    
    func updateMainUI()
    {
        dateLbl.text = weather.date
        currentTempLbl.text = "\(weather.currentTemperature)º"
        locationLbl.text = weather.cityCountryName
        if weather.weatherType == "Clouds"
        {
            CurrentWeatherConditionLbl.text = "Cloudy"
        }
        else
        {
            CurrentWeatherConditionLbl.text = weather.weatherType
        }
        weatherImg.image = UIImage(named: weather.weatherType)
        
    }
    
    func downloadForcast(completed: @escaping DownloadComplete)
    {
        Alamofire.request(forcastURL).responseJSON
        {
            response in let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>
            {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]
                {
                    for obj in list
                    {
                        let forcast = Forcast(weatherDict: obj)
                        self.forcasts.append(forcast)
                        print (obj)
                        
                    }
                    self.forcasts.remove(at: 0)
                    self.tableView.reloadData()
                }
                
            }
            
            completed()
        }
    }
}

