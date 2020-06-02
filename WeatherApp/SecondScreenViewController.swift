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
        
       finalCityName = finalCityName.replacingOccurrences(of: " ", with: "+")
        
        print("loaded view")
        print("Final city: \(finalCityName)")
        print("Final lot: \(finalLon)")
        print("Final lat: \(finalLat)")
        
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
                        
                        //Individuals days (after 3 hours weather)
                        guard let weatherDetails = json["list"] as? [[String: Any]],
                            let weatherMain = weatherDetails[0]["main"] as? [String: Any],
                            let temp = weatherMain["temp"] as? Double,
                            let weatherMain2 = weatherDetails[0]["weather"] as? [[String: Any]],
                            let desc = weatherMain2[0]["description"] as? String,
                            let weather = weatherMain2[0]["main"] as? String
                            else{return}
                            
                         guard let weatherCity = json["city"] as? [String: Any],
                            let name = weatherCity["name"] as? String,
                            let country = weatherCity["country"] as? String
                            else {return}
                        
                            DispatchQueue.main.async{
                                self.setWeather(weather: weather, description: desc, temp: Int(temp), name: name, country: country)
                            }
                    }
                    catch{
                        print("Error with data...")
                    }
                }
            }
            task.resume()
        print("task resume")
        }
    func setWeather(weather: String?,description: String?, temp: Int, name: String?, country: String?){
            descriptionWeather.text = description ?? "---"
            tempWeather.text = "\(temp)"
        print(temp)
            cityName.text = "\(name.unsafelyUnwrapped)"
            countryName.text = "\(country.unsafelyUnwrapped)"
            switch weather {
            case "Sunny":
                weatherIcon.image = UIImage(named: "Sunny")
            case "Rain":
                weatherIcon.image = UIImage(named: "Rainy")
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
