//
//  ThirdScreenViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 01/06/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit

class hourlyCell: UITableViewCell{
    
    //@IBOutlet weak var labelTemp: UILabel!
    //@IBOutlet weak var labelDate2: UILabel!
    //@IBOutlet weak var hourImage: UIImageView!
    
    @IBOutlet weak var LABEL_temp: UILabel!
    @IBOutlet weak var ICON_weather: UIImageView!
    @IBOutlet weak var LABEL_date: UILabel!
}

class ThirdScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var TOOLBAR_toolbarThirdView: UIToolbar!
    @IBOutlet weak var LABEL_cityName: UILabel!
    @IBOutlet weak var LABEL_temperature: UILabel!
    @IBOutlet weak var LABEL_description: UILabel!
    @IBOutlet weak var LABEL_pressure: UILabel!
    @IBOutlet weak var LABEL_humidity: UILabel!
    @IBOutlet weak var LABEL_wind: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var pass_cityName = ""
    var pass_BTN_Check_click = false
    var pass_url = ""
    var pass_latitude = ""
    var pass_longitude = ""
    var pass_temp = 0
    var pass_desc = ""
    var pass_pressure = 0
    var pass_humidity = 0
    var pass_wind = 0
    var pass_dateArray = [""]
    var pass_tempArray = [""]
    var pass_stateArray = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.tableFooterView = UIView()
    
        LABEL_cityName.text = pass_cityName
        LABEL_temperature.text = "\(pass_temp)"
        LABEL_description.text = pass_desc
        TOOLBAR_toolbarThirdView.setBackgroundImage(UIImage(),forToolbarPosition: .any, barMetrics: .default)
        TOOLBAR_toolbarThirdView.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        LABEL_pressure.text = "\(pass_pressure)"
        LABEL_humidity.text = "\(pass_humidity)"
        LABEL_wind.text = "\(pass_wind)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListItem", for: indexPath) as! hourlyCell
        
        let dateCell = self.pass_dateArray[indexPath.row]
        let tempCell = self.pass_tempArray[indexPath.row]
        let weatherCell = self.pass_stateArray[indexPath.row]
        
        switch weatherCell {
        case "Thunderstorm":
            cell.ICON_weather.image = UIImage(named: "Thunderstorm")
        case "Rain":
            cell.ICON_weather.image = UIImage(named: "Rain")
        case "Snow":
            cell.ICON_weather.image = UIImage(named: "Snow")
        case "Mist":
            cell.ICON_weather.image = UIImage(named: "Mist")
        case "Sunny":
            cell.ICON_weather.image = UIImage(named: "Sunny")
        case "Clouds":
            cell.ICON_weather.image = UIImage(named: "Cloudy")
        case "Clear":
            cell.ICON_weather.image = UIImage(named: "Sunny")
        default:
            cell.ICON_weather.image = UIImage(named: "Cloudy")
        }
    
        cell.isUserInteractionEnabled = false
        cell.LABEL_date?.text = dateCell
        cell.LABEL_temp?.text = "\(tempCell)"
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pass_dateArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc3 = segue.destination as? SecondScreenViewController
        
        vc3?.pass_cityName = self.pass_cityName
        vc3?.pass_BTN_Check_click = self.pass_BTN_Check_click
        vc3?.local_url = self.pass_url
        vc3?.pass_latitude = self.pass_latitude
        vc3?.pass_longitude = self.pass_longitude
        vc3?.local_temp = self.pass_temp
        vc3?.local_desc = self.pass_desc
    }
}
