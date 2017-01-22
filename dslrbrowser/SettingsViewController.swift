//
//  SettingsViewController.swift
//  dslrbrowser
//
//  Created by Andras Bekesi on 05/01/17.
//  Copyright © 2017 Andras Bekesi. All rights reserved.
//

import Foundation
import CoreLocation

class SettingsViewController:UITableViewController, CLLocationManagerDelegate {

    @IBOutlet var switchOnlyCanon:UISwitch?
    @IBOutlet var switchInsertGPS:UISwitch?
    let locationManager:CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs = UserDefaults.standard
        switchOnlyCanon?.setOn(prefs.bool(forKey: "useOnlyCanon"), animated: false)
        switchInsertGPS?.setOn(prefs.bool(forKey: "insertGPS"), animated: false)
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()

        let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if (status == CLAuthorizationStatus.authorizedAlways ||
            status == CLAuthorizationStatus.authorizedWhenInUse ) {
                switchInsertGPS?.isEnabled = true
        }
    }
    
    @IBAction func switchOnlyCanonChanged(sender: UISwitch) {
        let prefs = UserDefaults.standard
        prefs.set(sender.isOn, forKey: "useOnlyCanon")
    }
    
    @IBAction func switchInsertGPSChanged(sender: UISwitch) {
        let prefs = UserDefaults.standard
        prefs.set(sender.isOn, forKey: "insertGPS")
    }
    
    func locationManager(_ manager: CLLocationManager,
                                  didChangeAuthorization status: CLAuthorizationStatus) {

        if (status == CLAuthorizationStatus.authorizedAlways ||
            status == CLAuthorizationStatus.authorizedWhenInUse ) {
            switchInsertGPS?.isEnabled = true
        }
        
    }
    
}
