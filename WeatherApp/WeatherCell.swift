//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Jeremy Turney on 10/18/16.
//  Copyright © 2016 Jeremy Turney. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherMiniImg: UIImageView!
    
    @IBOutlet weak var dayLbl: UILabel!
    
    @IBOutlet weak var weatherConditionLbl: UILabel!
    
    @IBOutlet weak var highTempLbl: UILabel!
    
    @IBOutlet weak var lowTempLbl: UILabel!
    
    
    
    func configureCell(forcast: Forcast)
    {
        lowTempLbl.text = "Low \(forcast.lowTemp)º"
        highTempLbl.text = "High \(forcast.highTemp)º"
        weatherConditionLbl.text = forcast.weatherType
        weatherMiniImg.image = UIImage(named: "\(forcast.weatherType)")
        dayLbl.text = forcast.date
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
