//
//  PedometerInterfaceController.swift
//  AppleWatchSensors WatchKit Extension
//
//  Created by Atsushi Otsubo on 2022/09/10.
//

import WatchKit
import Foundation
import CoreMotion

class PedometerInterfaceController: WKInterfaceController {

    let pedometer = CMPedometer()
    @IBOutlet weak var pedometerLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
        // 1000秒前から現在までの値を取得する
        let from = Date(timeIntervalSinceNow: -1000)
        
        pedometer.startUpdates(from: from, withHandler: { [weak self] (pedometerData: CMPedometerData?, error: Error?) in
            guard let pedometerData = pedometerData else { return }
            DispatchQueue.main.async {
                self?.setPedometerInfo(pedometerData)
            }
            
        })
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    private func setPedometerInfo(_ pedometerData: CMPedometerData) {
        let pedometerInfo: String =
        """
            歩数\(pedometerData.numberOfSteps) 歩\n
            距離\(pedometerData.distance?.description ?? "0") m\n
            平均ペース\(pedometerData.averageActivePace?.description ?? "0") m / sec\n
            瞬間ペース\(pedometerData.currentPace?.description ?? "0") m / sec\n
            1秒間毎の歩数\(pedometerData.currentCadence?.description ?? "0")steps / sec\n
            登った階数\(pedometerData.floorsAscended?.description ?? "0") 階\n
            降った階数\(pedometerData.floorsAscended?.description ?? "0") 階\n
        """
        pedometerLabel.setText(pedometerInfo)
    }

}
