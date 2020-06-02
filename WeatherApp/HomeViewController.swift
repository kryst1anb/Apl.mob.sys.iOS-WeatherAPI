//
//  ViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 10/05/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet var BTN_Check: UIButton!
    @IBOutlet weak var BTN_Localization: UIButton!

    var cityName = ""
    var flag = false
    var lat_local = ""
    var lon_local = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BTN_Check.setTitleColor(UIColor(named: "ColorTextLD"), for: .normal)
        BTN_Check.tintColor = UIColor(named: "ColorTextLD")
        BTN_Check.layer.cornerRadius = 4
        
        BTN_Localization.setTitleColor(UIColor(named: "ColorTextLD"), for: .normal)
        BTN_Localization.tintColor = UIColor(named: "ColorTextLD")
    
    }
    
    @IBAction func SearchButton(_ sender: AnyObject) {
           print("pressed");
           flag = true
           self.cityName = cityInput.text!
           
           self.performSegue(withIdentifier: "SecondScreenView", sender: self)
       }
       
       @IBAction func LocalizationButton(_ sender: Any) {
           print("localization")
           flag = false
        
        let locManager = CLLocationManager()

           locManager.delegate = self
           locManager.desiredAccuracy = kCLLocationAccuracyBest
           locManager.requestWhenInUseAuthorization()
           locManager.startMonitoringSignificantLocationChanges()

           // Check if the user allowed authorization
           if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
               CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorized)
           {
            
            let lat = "\((locManager.location?.coordinate.latitude).unsafelyUnwrapped)"
            
            let lon = "\((locManager.location?.coordinate.longitude).unsafelyUnwrapped)"

            
            self.lon_local = lon
                self.lat_local = lat
            
                self.performSegue(withIdentifier: "SecondScreenView", sender: self)

               } else {
                   print("Location not authorized")
                  
               }
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SecondScreenViewController
        vc?.finalCityName = self.cityName
        vc?.finalflag = self.flag
        vc?.finalLat = self.lat_local
        vc?.finalLon = self.lon_local
    }

}
