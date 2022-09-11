//
//  LocationInterfaceController.swift
//  AppleWatchSensors WatchKit Extension
//
//  Created by Atsushi Otsubo on 2022/09/10.
//

import WatchKit
import CoreLocation

class LocationInterfaceController: WKInterfaceController {
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationInfoLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
    }
    
    override func willActivate() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    override func didDeactivate() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationInterfaceController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        
        let locationInfo: String =
        """
            緯度: \(latestLocation.coordinate.latitude)\n
            経度: \(latestLocation.coordinate.longitude)\n
            緯度経度の精度: \(latestLocation.horizontalAccuracy)\n
            高度: \(latestLocation.altitude)\n
            高度の精度: \(latestLocation.verticalAccuracy)\n
            速度: \(latestLocation.speed)\n
            速度の精度: \(latestLocation.speedAccuracy)\n
            階数: \(latestLocation.floor?.level ?? 0)\n
        """
        
        locationInfoLabel.setText(locationInfo)
    }
}

