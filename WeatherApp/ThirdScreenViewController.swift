//
//  ThirdScreenViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 01/06/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit

class ThirdScreenViewController: UIViewController{
    
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    
    var cityName = ""
    var flag = false
    var url = ""
    var lat = ""
    var lon = ""
    var temp = 0
    var desc = ""
    
    var pressure = 0
    var humidity = 0
    var wind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelCityName.text = cityName
        labelTemperature.text = "\(temp)"
        labelDescription.text = desc
        toolbar2.setBackgroundImage(UIImage(),forToolbarPosition: .any, barMetrics: .default)
        toolbar2.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        labelPressure.text = "\(pressure)"
        labelHumidity.text = "\(humidity)"
        labelWind.text = "\(wind)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc3 = segue.destination as? SecondScreenViewController
        
        vc3?.finalCityName = self.cityName
        vc3?.finalflag = self.flag
        vc3?.finalUrl = self.url
        vc3?.finalLat = self.lat
        vc3?.finalLon = self.lon
        vc3?.finalTemp = self.temp
        vc3?.finalDesc = self.desc
    }

}
