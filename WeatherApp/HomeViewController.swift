//
//  ViewController.swift
//  WeatherApp
//
//  Created by Klaudia Lewandowska on 10/05/2020.
//  Copyright © 2020 Klaudia Lewandowska. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var BTN_Check: UIButton!
    
    @IBOutlet weak var BTN_Localization: UIButton!

    
    
    
    @IBAction func SearchButton(_ sender: AnyObject) {
        print("pressed");
        self.performSegue(withIdentifier: "SecondScreenView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BTN_Check.setTitleColor(UIColor(named: "ColorTextLD"), for: .normal)
        BTN_Check.tintColor = UIColor(named: "ColorTextLD")
        BTN_Check.layer.cornerRadius = 4
        
        BTN_Localization.setTitleColor(UIColor(named: "ColorTextLD"), for: .normal)
        BTN_Localization.tintColor = UIColor(named: "ColorTextLD")
        
        
        
    }

}
