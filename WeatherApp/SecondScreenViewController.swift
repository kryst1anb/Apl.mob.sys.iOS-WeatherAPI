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
    @IBOutlet weak var toolbar1: UIToolbar!
    
    var finalCityName = ""
    var finalflag = false
    var finalUrl = ""
    var finalLat = ""
    var finalLon = ""
    var finalTemp = 0
    var finalDesc = ""
    var finalDateArray = [""]
    
    var finalPressure = 0
    var finalHumidity = 0
    var finalWind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbar1.setBackgroundImage(UIImage(),forToolbarPosition: .any, barMetrics: .default)
        toolbar1.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        
       finalCityName = finalCityName.replacingOccurrences(of: " ", with: "+")
        
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
                            
                            let pressure = weatherMain["pressure"] as? Double,
                            let humidity = weatherMain["humidity"] as? Double,
                            
                            
                            let weatherWind = weatherDetails[0]["wind"] as? [String: Any],
                            let wind = weatherWind["speed"] as? Double,
                            
                        
                            let weatherMain2 = weatherDetails[0]["weather"] as? [[String: Any]],
                            let desc = weatherMain2[0]["description"] as? String,
                            let weather = weatherMain2[0]["main"] as? String
                            else{return}
                            
                         guard let weatherCity = json["city"] as? [String: Any],
                            let name = weatherCity["name"] as? String,
                            let country = weatherCity["country"] as? String
                            else {return}
                        
                        for data in weatherDetails{
                            
                            let weatherData = data["dt_txt"] as? String
                            var word = "\(weatherData.unsafelyUnwrapped)"
                            word.removeLast(3)
                            self.finalDateArray.append("\(word)")
                            
                        }

                        self.finalDateArray.remove(at: 0)
                        print(self.finalDateArray)
                            DispatchQueue.main.async{
                                self.setWeather(weather: weather, description: desc, temp: Int(temp), name: name, country: country, pressure: Int(pressure), humidity: Int(humidity), wind: Int(wind), date: self.finalDateArray)
                            }
                    }
                    catch{
                        print("Error with data...")
                    }
                }
            }
            task.resume()
        }
    func setWeather(weather: String?,description: String?, temp: Int, name: String?, country: String?, pressure: Int, humidity: Int, wind: Int, date: [String]){
            descriptionWeather.text = description ?? "---"
            finalDesc = description ?? ""
            tempWeather.text = "\(temp)"
            finalTemp = temp
            cityName.text = "\(name.unsafelyUnwrapped)"
            finalCityName = "\(name.unsafelyUnwrapped)"
            countryName.text = "\(country.unsafelyUnwrapped)"
        
            finalPressure = pressure
            finalHumidity = humidity
            finalWind = wind
            finalDateArray = date
       //print("Date:", date)

        
        
            switch weather {
            case "Sunny":
                weatherIcon.image = UIImage(named: "Sunny")
            case "Rain":
                weatherIcon.image = UIImage(named: "Rainy")
            default:
                weatherIcon.image = UIImage(named: "Cloudy")
            
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc2 = segue.destination as? ThirdScreenViewController
        
        vc2?.cityName = self.finalCityName
        vc2?.flag = self.finalflag
        vc2?.url = self.finalUrl
        vc2?.lat = self.finalLat
        vc2?.lon = self.finalLon
        vc2?.temp = self.finalTemp
        vc2?.desc = self.finalDesc
        vc2?.pressure = self.finalPressure
        vc2?.humidity = self.finalHumidity
        vc2?.wind = self.finalWind
        vc2?.dateArray = self.finalDateArray
    }
}

extension String {
func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased()+self.lowercased().dropFirst()
    }
}
