//
//  AltimeterViewController.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//


import UIKit
import CoreMotion

class AltimeterViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var altimeter: CMAltimeter!
    
    var motionInfomations: [KeyValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureAltimeterManager()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyValueCell.nib(), forCellWithReuseIdentifier: KeyValueCell.reuseIdentifier)
    }
    
    private func configureAltimeterManager() {
        altimeter = CMAltimeter()
        guard let altimeter = altimeter else { return }
        if CMAltimeter.isRelativeAltitudeAvailable() {
            
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { [weak self] (altitudeData: CMAltitudeData?, error: Error?) in
                guard let altitudeData = altitudeData else { return }
                self?.setAltimeterInfomation(altitudeData)
            })
        }
    }

}

extension AltimeterViewController {
    func setAltimeterInfomation(_ altitudeData: CMAltitudeData) {
        motionInfomations.removeAll()
        motionInfomations.append(KeyValue(key: "高度:", value: "\(altitudeData.relativeAltitude.toString)", unit: "m"))
        motionInfomations.append(KeyValue(key: "気圧:", value: "\(altitudeData.pressure.toString)", unit: "kPa"))
        collectionView.reloadData()
    }
}

extension AltimeterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return motionInfomations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyValueCell.reuseIdentifier, for: indexPath) as! KeyValueCell
        let infomation = motionInfomations[indexPath.row]
        cell.setup(key: infomation.key, value: infomation.value, unit: infomation.unit)
        return cell
    }
}

extension AltimeterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: KeyValueCell.cellHeight)
    }
}

