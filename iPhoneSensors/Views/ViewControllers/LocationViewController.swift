//
//  LocationViewController.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/09.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var locationManager: CLLocationManager!
    
    var locationInfomations: [KeyValue] = [KeyValue(key: "", value: "値の取得中...")]
    var visitInfomations: [KeyValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureLocationManager()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyValueCell.nib(), forCellWithReuseIdentifier: KeyValueCell.reuseIdentifier)
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        // locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        locationInfomations.removeAll()
        locationInfomations.append(KeyValue(key: "緯度:", value: "\(location.coordinate.latitude)"))
        locationInfomations.append(KeyValue(key: "経度:", value: "\(location.coordinate.longitude)"))
        locationInfomations.append(KeyValue(key: "緯度経度の精度:", value: "\(location.horizontalAccuracy)", unit: "m"))
        locationInfomations.append(KeyValue(key: "高度:", value: "\(location.altitude)", unit: "m"))
        locationInfomations.append(KeyValue(key: "高度の精度:", value: "\(location.verticalAccuracy)", unit: "m"))
        locationInfomations.append(KeyValue(key: "速度:", value: "\(location.speed)", unit: "meter/sec"))
        locationInfomations.append(KeyValue(key: "速度の精度:", value: "\(location.speedAccuracy)", unit: "meter/sec"))
        
        if let floor = location.floor {
            locationInfomations.append(KeyValue(key: "階数:", value: "\(floor.level)"))
        } else {
            locationInfomations.append(KeyValue(key: "階数:", value: "N/A"))
        }
        collectionView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        visitInfomations.removeAll()
        visitInfomations.append(KeyValue(key: "到着時刻:", value: "\(visit.arrivalDate)"))
        visitInfomations.append(KeyValue(key: "出発時刻:", value: "\(visit.departureDate)"))
        collectionView.reloadData()
    }
}

extension LocationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let infomations = locationInfomations + visitInfomations
        return infomations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyValueCell.reuseIdentifier, for: indexPath) as! KeyValueCell
        let infomations = locationInfomations + visitInfomations
        let infomation = infomations[indexPath.row]
        cell.setup(key: infomation.key, value: infomation.value, unit: infomation.unit)
        return cell
    }
}

extension LocationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: KeyValueCell.cellHeight)
    }
}
