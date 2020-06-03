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

    let locationManager = CLLocationManager()
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
        
        locationManager.requestAlwaysAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
        
    }
           func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               if let location = locations.first {
                let lat = "\((locationManager.location?.coordinate.latitude).unsafelyUnwrapped)"
                let lon = "\((locationManager.location?.coordinate.longitude).unsafelyUnwrapped)"

                self.lon_local = lon
                self.lat_local = lat

                self.performSegue(withIdentifier: "SecondScreenView", sender: self)
               }
           }
           
           // If deined access give the user the option to change it
           func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
               if(status == CLAuthorizationStatus.denied) {
                   showLocationDisabledPopUp()
               }
           }
           
           // Show the popup to the user if deined access
           func showLocationDisabledPopUp() {
               let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                       message: "To get current Weather we need your location",
                                                       preferredStyle: .alert)
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alertController.addAction(cancelAction)
               
               let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                   }
               }
               alertController.addAction(openAction)
               
               self.present(alertController, animated: true, completion: nil)
           }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SecondScreenViewController
        vc?.finalCityName = self.cityName
        vc?.finalflag = self.flag
        vc?.finalLat = self.lat_local
        vc?.finalLon = self.lon_local
    }

}
