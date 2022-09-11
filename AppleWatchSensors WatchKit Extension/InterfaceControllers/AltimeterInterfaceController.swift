//
//  AltimeterInterfaceController.swift
//  AppleWatchSensors WatchKit Extension
//
//  Created by Atsushi Otsubo on 2022/09/10.
//

import WatchKit
import Foundation
import CoreMotion

class AltimeterInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var altitudeLabel: WKInterfaceLabel!
    let altimeter = CMAltimeter()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!, withHandler: { [weak self] altitudeData,_ in
            guard let altitudeData = altitudeData else { return }
            self?.setAltitudeInfo(altitudeData)
        })
    }
    
    private func setAltitudeInfo(_ altitudeData: CMAltitudeData) {
        let altitudeInfo: String =
        """
            気圧:\(altitudeData.pressure)\n
            相対高度:\(altitudeData.relativeAltitude)\n
        """
        altitudeLabel.setText(altitudeInfo)
    }

    override func didDeactivate() {
        super.didDeactivate()
        altimeter.stopRelativeAltitudeUpdates()
    }

}
