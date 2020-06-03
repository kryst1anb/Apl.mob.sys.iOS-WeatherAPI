//
//  ThirdScreenViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 01/06/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell{
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
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
    //var inTtempArray: [Int] = []
    
    var pressure = 0
    var humidity = 0
    var wind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        
        

      //  inTtempArray = tempArray.compactMap({ Int($0) })
      //  print(inTtempArray)
        
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
        //let cell = UITableViewCell()
        //cell.textLabel?.text = title
        cell.labelDate?.text = title
        cell.labelTemp?.text = "\(temp)"
        cell.hourImage.image = UIImage(named: "Humidity")

        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dateArray.count
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
