//
//  MotionInterfaceController.swift
//  AppleWatchSensors WatchKit Extension
//
//  Created by Atsushi Otsubo on 2022/09/10.
//

import WatchKit
import Foundation
import CoreMotion


class MotionInterfaceController: WKInterfaceController {
    let motionManager = CMMotionManager()
    @IBOutlet weak var motionInfoLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
        motionManager.startDeviceMotionUpdates(to: .main, withHandler: { motion,_ in
            guard let deviceMotion = motion else { return }
            
            let motionInfo: String =
            """
                姿勢 (pitch):\(deviceMotion.attitude.pitch)\n
                姿勢 (roll):\(deviceMotion.attitude.roll)\n
                姿勢 (yaw):\(deviceMotion.attitude.yaw)\n
                ジャイロ (X):\(deviceMotion.rotationRate.x)\n
                ジャイロ (Y):\(deviceMotion.rotationRate.y)\n
                ジャイロ (Z):\(deviceMotion.rotationRate.z)\n
                重力 (X):\(deviceMotion.gravity.x)\n
                重力 (Y):\(deviceMotion.gravity.y)\n
                重力 (Z):\(deviceMotion.gravity.z)\n
                加速度 (X):\(deviceMotion.userAcceleration.x)\n
                加速度 (Y):\(deviceMotion.userAcceleration.y)\n
                加速度 (Z):\(deviceMotion.userAcceleration.z)\n
            """
            self.motionInfoLabel.setText(motionInfo)
        })
    }

    override func didDeactivate() {
        super.didDeactivate()
        motionManager.stopDeviceMotionUpdates()
    }

}
