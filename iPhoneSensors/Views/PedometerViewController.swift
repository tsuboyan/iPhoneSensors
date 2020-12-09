//
//  PedometerViewController.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import UIKit
import CoreMotion

class PedometerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var pedometer: CMPedometer!
    
    var motionInfomations: [KeyValue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configurePedometerManager()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyValueCell.nib(), forCellWithReuseIdentifier: KeyValueCell.reuseIdentifier)
    }
    
    private func configurePedometerManager() {
        pedometer = CMPedometer()
        guard let pedometer = pedometer else { return }
        if CMPedometer.isStepCountingAvailable() {
            
            // 1000秒前から現在までの値を取得する
            let from = Date(timeIntervalSinceNow: -1000)
            
            pedometer.startUpdates(from: from, withHandler: { [weak self] (pedometerData: CMPedometerData?, error: Error?) in
                guard let pedometerData = pedometerData else { return }
                DispatchQueue.main.async {
                    self?.setPedometerInfomation(pedometerData)
                }
                
            })
        }
    }

}

extension PedometerViewController {
    func setPedometerInfomation(_ pedometerData: CMPedometerData) {
        motionInfomations.removeAll()
        motionInfomations.append(KeyValue(key: "歩数:", value: "\(pedometerData.numberOfSteps)", unit: "歩"))
        motionInfomations.append(KeyValue(key: "距離:", value: "\(pedometerData.distance?.toString ?? "0")", unit: "m"))
        motionInfomations.append(KeyValue(key: "平均ペース:", value: "\(pedometerData.averageActivePace?.toString ?? "0")", unit: "meter / sec"))
        motionInfomations.append(KeyValue(key: "瞬間ペース:", value: "\(pedometerData.currentPace?.toString ?? "0")", unit: "meter / sec"))
        motionInfomations.append(KeyValue(key: "1秒間毎の歩数:", value: "\(pedometerData.currentCadence?.toString ?? "0")", unit: "steps / sec"))
        motionInfomations.append(KeyValue(key: "登った階数:", value: "\(pedometerData.floorsAscended?.toString ?? "0")", unit: "階"))
        motionInfomations.append(KeyValue(key: "降った階数:", value: "\(pedometerData.floorsAscended?.toString ?? "0")", unit: "階"))
        
        collectionView.reloadData()
    }
}

extension PedometerViewController: UICollectionViewDataSource {
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

extension PedometerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: KeyValueCell.cellHeight)
    }
}

