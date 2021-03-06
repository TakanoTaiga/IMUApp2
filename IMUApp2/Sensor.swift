//
//  Sensor.swift
//  IMUApp
//
//  Created by 高野大河 on 2021/07/01.
//

import Foundation
import UIKit
import CoreMotion


class MotionSensorV2 : ObservableObject{
    private var motionManger = CMMotionManager()
    private func updateMotionData(deviceMotion:CMDeviceMotion) {
        let inputMotion = deviceMotion.attitude.yaw * (180.0 / Double.pi)
        if inputMotion >= 0{
            degree = inputMotion
        }else if inputMotion < 0 {
            degree = 360 + inputMotion
        }else{
            degree = 0;
        }
        //degree = inputMotion
    }
    
    private func start(){
        if motionManger.isDeviceMotionAvailable{
            motionManger.deviceMotionUpdateInterval = 0.2
            motionManger.startDeviceMotionUpdates(to: OperationQueue.current! , withHandler: {(motion:CMDeviceMotion? , error:Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }
    }
    
    func reset(){
        motionManger.stopDeviceMotionUpdates()
        start()
    }
    
    @Published var degree = -1.0
    
    init() {
        start()
    }
}
