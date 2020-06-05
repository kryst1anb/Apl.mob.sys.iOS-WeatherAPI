import UIKit

class SecondScreenViewController: UIViewController {
    
    //@IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var LABEL_cityName: UILabel!
    
    //@IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var LABEL_countryName: UILabel!
    
    //@IBOutlet weak var tempWeather: UILabel!
    @IBOutlet weak var LABEL_tempWeather: UILabel!
    
    //@IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var ICON_weather: UIImageView!
    
    //@IBOutlet weak var descriptionWeather: UILabel!
    @IBOutlet weak var LABEL_descriptionWeather: UILabel!
    
    //@IBOutlet weak var toolbar1: UIToolbar!
    @IBOutlet weak var TOOLBAR_toolbarSecondView: UIToolbar!
    @IBOutlet weak var LABEL_celsius: UILabel!
    
    
    var pass_cityName = ""
    var pass_BTN_Check_click = false
    var pass_latitude = ""
    var pass_longitude = ""
    
    var local_url = ""
    var local_temp = 0
    var local_desc = ""
    var local_dateArray = [""]
    var local_tempArray = [""]
    var local_weatherState = [""]
    var local_pressure = 0
    var local_humidity = 0
    var local_windSpeed = 0
    
    func goToHomeView (){
        self.performSegue(withIdentifier: "goToHomeView", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TOOLBAR_toolbarSecondView.setBackgroundImage(UIImage(),forToolbarPosition: .any, barMetrics: .default)
        TOOLBAR_toolbarSecondView.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        pass_cityName = pass_cityName.replacingOccurrences(of: " ", with: "+")
        
        if pass_BTN_Check_click == true{
            local_url = "https://api.openweathermap.org/data/2.5/forecast?q=\(pass_cityName)&units=metric&appid=b314601205f4c241d94fa31f7c339a88"
        }
        else{
            local_url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(pass_latitude)&lon=\(pass_longitude)&units=metric&appid=b314601205f4c241d94fa31f7c339a88"
        }
        
        guard let url = URL(string: "\(local_url)") else {return}
            let task = URLSession.shared.dataTask(with: url){(data, response, error) in
                if let data = data, error == nil{
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode != 200{
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Error",
                                                                        message: "Not found city \(self.pass_cityName)",
                                                                           preferredStyle: .alert)

                                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.goToHomeView() }))
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    do{
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                            else {return}
                        
                        //Individuals days (after 3 hours weather)
                        guard let jsonList = json["list"] as? [[String: Any]],
                            let jsonMain = jsonList[0]["main"] as? [String: Any],
                            let jsonMainTemp = jsonMain["temp"] as? Double,
                            
                            let jsonMainPressure = jsonMain["pressure"] as? Double,
                            let jsonMainHumidity = jsonMain["humidity"] as? Double,
                            
                            let jsonWind = jsonList[0]["wind"] as? [String: Any],
                            let jsonWindSpeed = jsonWind["speed"] as? Double,
                        
                            let jsonWeather = jsonList[0]["weather"] as? [[String: Any]],
                            let jsonWeatherDescription = jsonWeather[0]["description"] as? String,
                            let jsonWeatherMain = jsonWeather[0]["main"] as? String
                        else{return}
                            
                        guard let jsonCity = json["city"] as? [String: Any],
                            let jsonCityName = jsonCity["name"] as? String,
                            let jsonCityCountry = jsonCity["country"] as? String
                        else {return}
                        
                        
                        for data in jsonList{
                            
                            let jsonDataTime = data["dt_txt"] as? String
                            
                            if let jsonDataWeather = data["weather"] as? [[String: Any]]{
                                let jsonDataWeatherMain = jsonDataWeather[0]["main"] as? String
                                self.local_weatherState.append("\(jsonDataWeatherMain.unsafelyUnwrapped)")
                            }
                            else{return}
                            
                            if let jsonDataMain = data["main"] as? [String: Any]{
                            
                                let jsonDataMainTemp = jsonDataMain["temp"] as? Double
                                let jsonDataMainTempUnwrapped = "\(jsonDataMainTemp.unsafelyUnwrapped)"
                                let jsonDataMainTempValue = jsonDataMainTempUnwrapped.components(separatedBy: ["."])
                                
                                self.local_tempArray.append("\(jsonDataMainTempValue[0]) °C")
                            }
                            else{return}
                                
                            var jsonDataTimeUnwrapped = "\(jsonDataTime.unsafelyUnwrapped)"
                            jsonDataTimeUnwrapped.removeLast(3)
                            self.local_dateArray.append("\(jsonDataTimeUnwrapped)")
                            
                        }

                        self.local_dateArray.remove(at: 0)
                        self.local_tempArray.remove(at: 0)
                        self.local_weatherState.remove(at: 0)
                        
                            DispatchQueue.main.async{
                                self.setWeather(weather: jsonWeatherMain, description: jsonWeatherDescription, temp: Int(jsonMainTemp), name: jsonCityName, country: jsonCityCountry, pressure: Int(jsonMainPressure), humidity: Int(jsonMainHumidity), wind: Int(jsonWindSpeed), date: self.local_dateArray, tempArray: self.local_tempArray, weatherState: self.local_weatherState)
                            }
                    }
                    catch{
                        print("Error with data...")
                    }
                }
            }
            task.resume()
        }
    func setWeather(weather: String?, description: String?, temp: Int, name: String?, country: String?, pressure: Int, humidity: Int, wind: Int, date: [String], tempArray: [String], weatherState: [String])
    {
        
            ICON_weather.isHidden = false
            LABEL_celsius.isHidden = false
        
            LABEL_descriptionWeather.text = description ?? ""
            local_desc = description ?? ""
        
            LABEL_tempWeather.text = "\(temp)"
            local_temp = temp
        
            LABEL_cityName.text = "\(name.unsafelyUnwrapped)"
            pass_cityName = "\(name.unsafelyUnwrapped)"
        
            LABEL_countryName.text = "\(country.unsafelyUnwrapped)"
        
            local_pressure = pressure
            local_humidity = humidity
            local_windSpeed = wind
            local_dateArray = date
            local_tempArray = tempArray
            local_weatherState = weatherState

            switch weather {
            case "Thunderstorm":
                ICON_weather.image  = UIImage(named: "Thunderstorm")
            case "Rain":
                ICON_weather.image  = UIImage(named: "Rain")
            case "Snow":
                ICON_weather.image  = UIImage(named: "Snow")
            case "Mist":
                ICON_weather.image  = UIImage(named: "Mist")
            case "Sunny":
                ICON_weather.image  = UIImage(named: "Sunny")
            case "Clouds":
                ICON_weather.image  = UIImage(named: "Cloudy")
            case "Clear":
                ICON_weather.image = UIImage(named: "Sunny")
            default:
                ICON_weather.image = UIImage(named: "Cloudy")
                
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc2 = segue.destination as? ThirdScreenViewController
        
        vc2?.cityName = self.pass_cityName
        vc2?.flag = self.pass_BTN_Check_click
        vc2?.url = self.local_url
        vc2?.lat = self.pass_latitude
        vc2?.lon = self.pass_longitude
        vc2?.temp = self.local_temp
        vc2?.desc = self.local_desc
        vc2?.pressure = self.local_pressure
        vc2?.humidity = self.local_humidity
        vc2?.wind = self.local_windSpeed
        vc2?.dateArray = self.local_dateArray
        vc2?.tempArray = self.local_tempArray
        vc2?.stateArray = self.local_weatherState
    }
}

extension String {
func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased()+self.lowercased().dropFirst()
    }
}
