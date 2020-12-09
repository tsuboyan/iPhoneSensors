//
//  MotionViewController.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import UIKit
import CoreMotion

class MotionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var motionManager: CMMotionManager!
    
    var motionInfomations: [KeyValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureMotionManager()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyValueCell.nib(), forCellWithReuseIdentifier: KeyValueCell.reuseIdentifier)
    }
    
    private func configureMotionManager() {
        motionManager = CMMotionManager()
        guard let motionManager = motionManager else { return }
        // motionManager.deviceMotionUpdateInterval = 1
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { [weak self] (motion: CMDeviceMotion?, error: Error?) in
                guard let motion = motion else { return }
                self?.setMotionInfomation(motion)
            })
        }
    }

}

extension MotionViewController {
    func setMotionInfomation(_ deviceMotion: CMDeviceMotion) {
        motionInfomations.removeAll()
        motionInfomations.append(KeyValue(key: "姿勢 (pitch):", value: "\(deviceMotion.attitude.pitch)"))
        motionInfomations.append(KeyValue(key: "姿勢 (roll):", value: "\(deviceMotion.attitude.roll)"))
        motionInfomations.append(KeyValue(key: "姿勢 (yaw):", value: "\(deviceMotion.attitude.yaw)"))
        motionInfomations.append(KeyValue(key: "ジャイロ (X):", value: "\(deviceMotion.rotationRate.x)"))
        motionInfomations.append(KeyValue(key: "ジャイロ (Y):", value: "\(deviceMotion.rotationRate.y)"))
        motionInfomations.append(KeyValue(key: "ジャイロ (Z):", value: "\(deviceMotion.rotationRate.z)"))
        motionInfomations.append(KeyValue(key: "重力 (X):", value: "\(deviceMotion.gravity.x)", unit: "G"))
        motionInfomations.append(KeyValue(key: "重力 (Y):", value: "\(deviceMotion.gravity.y)", unit: "G"))
        motionInfomations.append(KeyValue(key: "重力 (Z):", value: "\(deviceMotion.gravity.z)", unit: "G"))
        motionInfomations.append(KeyValue(key: "加速度 (X):", value: "\(deviceMotion.userAcceleration.x)", unit: "G"))
        motionInfomations.append(KeyValue(key: "加速度 (Y):", value: "\(deviceMotion.userAcceleration.y)", unit: "G"))
        motionInfomations.append(KeyValue(key: "加速度 (Z):", value: "\(deviceMotion.userAcceleration.z)", unit: "G"))
        collectionView.reloadData()
    }
}

extension MotionViewController: UICollectionViewDataSource {
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

extension MotionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: KeyValueCell.cellHeight)
    }
}
