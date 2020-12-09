//
//  ProximityViewController.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import UIKit

class ProximityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var proximityInfomations: [KeyValue] = [KeyValue(key: "", value: "値の取得中...")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureProximity()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIScreen.brightnessDidChangeNotification,
                                                  object: nil)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyValueCell.nib(), forCellWithReuseIdentifier: KeyValueCell.reuseIdentifier)
    }
    
    private func configureProximity() {
        UIDevice.current.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(proximityChanged(_:)),
                                               name: UIDevice.proximityStateDidChangeNotification,
                                               object: nil)
    }
    
}

extension ProximityViewController {
    @objc func proximityChanged(_ notification: Notification) {
        proximityInfomations.removeAll()
        if let uiDeviceObject = notification.object {
            let proximityState = (uiDeviceObject as AnyObject).proximityState ?? false
            proximityInfomations.append(KeyValue(key: "近接している?", value: proximityState ? "はい" : "いいえ"))
        }
        collectionView.reloadData()
    }
}

extension ProximityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return proximityInfomations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyValueCell.reuseIdentifier, for: indexPath) as! KeyValueCell
        let infomation = proximityInfomations[indexPath.row]
        cell.setup(key: infomation.key, value: infomation.value, unit: infomation.unit)
        return cell
    }
}

extension ProximityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: KeyValueCell.cellHeight)
    }
}



