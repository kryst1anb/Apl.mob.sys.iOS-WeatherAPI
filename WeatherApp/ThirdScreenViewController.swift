//
//  ThirdScreenViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 01/06/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell{
    
    //@IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDate2: UILabel!
    @IBOutlet weak var hourImage: UIImageView!
}

class ThirdScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var toolbar2: UIToolbar!
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var cityName = ""
    var flag = false
    var url = ""
    var lat = ""
    var lon = ""
    var temp = 0
    var desc = ""
    
    var dateArray = [""]
    var tempArray = [""]
    var stateArray = [""]
    
    var pressure = 0
    var humidity = 0
    var wind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.tableFooterView = UIView()
    
        labelCityName.text = cityName
        labelTemperature.text = "\(temp)"
        labelDescription.text = desc
        toolbar2.setBackgroundImage(UIImage(),forToolbarPosition: .any, barMetrics: .default)
        toolbar2.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        labelPressure.text = "\(pressure)"
        labelHumidity.text = "\(humidity)"
        labelWind.text = "\(wind)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListItem", for: indexPath) as! MyCell
        
        let title = self.dateArray[indexPath.row]
        let temp = self.tempArray[indexPath.row]
        let state = self.stateArray[indexPath.row]
        
        switch state {
        case "Thunderstorm":
            cell.hourImage.image = UIImage(named: "Thunderstorm")
        case "Rain":
            cell.hourImage.image = UIImage(named: "Rain")
        case "Snow":
            cell.hourImage.image = UIImage(named: "Snow")
        case "Mist":
            cell.hourImage.image = UIImage(named: "Mist")
        case "Sunny":
            cell.hourImage.image = UIImage(named: "Sunny")
        case "Clouds":
            cell.hourImage.image = UIImage(named: "Cloudy")
        case "Clear":
            cell.hourImage.image = UIImage(named: "Sunny")
        default:
            cell.hourImage.image = UIImage(named: "Cloudy")
        }
    
        cell.isUserInteractionEnabled = false
        cell.labelDate2?.text = title
        cell.labelTemp?.text = "\(temp)"
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dateArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc3 = segue.destination as? SecondScreenViewController
        
        vc3?.pass_cityName = self.cityName
        vc3?.pass_BTN_Check_click = self.flag
        vc3?.local_url = self.url
        vc3?.pass_latitude = self.lat
        vc3?.pass_longitude = self.lon
        vc3?.local_temp = self.temp
        vc3?.local_desc = self.desc
    }
}
