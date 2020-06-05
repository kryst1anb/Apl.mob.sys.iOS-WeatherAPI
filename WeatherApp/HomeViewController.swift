import UIKit
import CoreLocation
import Foundation
import Network

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    // Items from HomeViewController
    //@IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var INPUT_City: UITextField!
    @IBOutlet var BTN_Check: UIButton!
    @IBOutlet weak var BTN_Localization: UIButton!
    
    // Locale variables
    let locationManager = CLLocationManager()
    var local_cityName = ""
    var flag_BTN_Check_click = false
    var local_latitude = ""
    var local_longitude = ""
    
    var errorCode = ""
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
               
        // Setting view of button check city
        BTN_Check.setTitleColor(UIColor(named: "ColorTextLD"), for: .normal)
        BTN_Check.tintColor = UIColor(named: "ColorTextLD")
        BTN_Check.layer.cornerRadius = 4
        
        // Setting view of button Localization
        BTN_Localization.setTitleColor(UIColor(named: "ColorTextLD"), for: .normal)
        BTN_Localization.tintColor = UIColor(named: "ColorTextLD")
        
        self.checkInternetConnection()
    }
    
    func checkInternetConnection(){
        
        let monitor=NWPathMonitor()
               
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied{
                       
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
            
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

    }
    
    @IBAction func SearchButton(_ sender: AnyObject) {

        let ifNumbers = INPUT_City.text?.rangeOfCharacter(from: .decimalDigits)

        print("Pressed button Check")
               
        if (INPUT_City.text!.count > 0 && ifNumbers == nil){
            flag_BTN_Check_click = true
            var cityNameString = INPUT_City.text!
            
            let data = cityNameString.data(using: .utf8)!
            cityNameString = String(decoding : data, as: UTF8.self)
            
            self.local_cityName = cityNameString
            self.performSegue(withIdentifier: "SecondScreenView", sender: self)
        }else{
            let alertController = UIAlertController(title: "Error",
                                                    message: "Uncorrect name",
                                                           preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
       
    @IBAction func LocalizationButton(_ sender: Any) {
        
        
        
        print("Pressed button Localization")
        
        flag_BTN_Check_click = false
        locationManager.requestAlwaysAuthorization()
            
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if let location = locations.first {
        let latitude = "\((locationManager.location?.coordinate.latitude).unsafelyUnwrapped)"
        let longitude = "\((locationManager.location?.coordinate.longitude).unsafelyUnwrapped)"

        self.local_longitude = longitude
        self.local_latitude = latitude
        self.performSegue(withIdentifier: "SecondScreenView", sender: self)
        //}
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
                                                       message: "To get current weather we need your location",
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
    
    // Passed variables to SecondScreenViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SecondScreenViewController
        vc?.pass_cityName = self.local_cityName
        vc?.pass_BTN_Check_click = self.flag_BTN_Check_click
        vc?.pass_latitude = self.local_latitude
        vc?.pass_longitude = self.local_longitude
    }
}
