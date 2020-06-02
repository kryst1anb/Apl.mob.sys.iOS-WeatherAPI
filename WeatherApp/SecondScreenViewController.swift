//
//  SecondScreenViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 01/06/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit

class SecondScreenViewController: UIViewController {
    
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var tempWeather: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionWeather: UILabel!
    
    var finalCityName = ""
    var finalflag = false
    var finalUrl = ""
    var finalLat = ""
    var finalLon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded view")
        print(finalCityName)
        print(finalLon)
        print(finalLat)
        
        if finalflag == true{
            finalUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(finalCityName)&units=metric&appid=b314601205f4c241d94fa31f7c339a88"
        }
        else{
            finalUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(finalLat)&lon=\(finalLon)&units=metric&appid=b314601205f4c241d94fa31f7c339a88"
        }
        
        guard let url = URL(string: "\(finalUrl)") else {return}
            let task = URLSession.shared.dataTask(with: url){(data, response, error) in
                if let data = data, error == nil{
                    do{
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                            else {return}
                        guard let weatherDetails = json["list"] as? [[String: Any]], let weatherMain = json["main"] as? [String: Any]
                            else {return}
                        let temp = Int(weatherMain["temp"] as? Double ?? 0)
                        let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                        DispatchQueue.main.async{
                            self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp)
                        }
                    }catch{
                        print("Error with data...")
                    }
                }
            }
            task.resume()
        print("task resume")
        }
        func setWeather(weather: String?,description: String?, temp: Int){
            descriptionWeather.text = description ?? "---"
            tempWeather.text = "\(temp)"
            switch weather {
            case "Sunny":
                weatherIcon.image = UIImage(named: "Sunny")
            default:
                weatherIcon.image = UIImage(named: "Cloudy")
            
            }
       
    }

}

extension String {
func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased()+self.lowercased().dropFirst()
    }
    
}
