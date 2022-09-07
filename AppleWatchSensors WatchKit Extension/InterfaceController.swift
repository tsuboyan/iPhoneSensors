//
//  InterfaceController.swift
//  AppleWatchSensors WatchKit Extension
//
//  Created by Atsushi Otsubo on 2022/09/07.
//

import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {

    let motionManager = CMMotionManager()
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        motionManager.startDeviceMotionUpdates(to: .main, withHandler: { motion,_ in
            if let motion = motion {
                print(motion)
            }
        })
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        motionManager.stopDeviceMotionUpdates()
    }

}
