//
//  SensorDataManager.swift
//  bumpy
//
//  Created by Malte Bünz on 06.11.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import Foundation
import CoreMotion

class MotionDataManager: CMMotionManager {
    
    static let shared: MotionDataManager = {
        return MotionDataManager()
    }()
    private let motionQueue = OperationQueue()
    
    override init() {
        super.init()
    }
    
    public func stopMotionUpdates() {
        super.stopDeviceMotionUpdates()
        super.stopAccelerometerUpdates()
    }
    
    // MARK: Accelerometer Data
    public func startAccelerometerUpdatesIfAvailable() {
        if !self.isAccelerometerAvailable {
            debugPrint("Accelerometer is not available")
        } else {
            super.startAccelerometerUpdates()
        }
    }
    
    public func startAccelelometerUpdatesToMotionQueue(withHandler handler: @escaping CMAccelerometerHandler) {
        if !self.isAccelerometerAvailable {
            debugPrint("Accelerometer is not available")
        } else {
            super.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
        }
    }
    
    public func startAccelelometerUpdatesToMotionQueue(byInterval interval: TimeInterval, withHandler handler: @escaping CMAccelerometerHandler) {
        if !self.isAccelerometerAvailable {
            debugPrint("Accelerometer is not available")
        } else {
            super.accelerometerUpdateInterval = interval
            super.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
        }
    }
    
    // MARK: Device motion
    open func startDeviceMotionUpdatesIfAvailable() {
        if !self.isDeviceMotionAvailable {
            debugPrint("DeviceMotion is not available")
        } else {
            super.startDeviceMotionUpdates()
        }
    }
    
    open func startDeviceMotionUpdatesToMotionQueue(withHandler handler: @escaping CMDeviceMotionHandler) {
        if !self.isDeviceMotionAvailable {
            debugPrint("Devicemotion is not available")
        } else {
            super.startDeviceMotionUpdates(to: motionQueue, withHandler: handler)
        }
    }
    
    open func startDeviceMotionUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMDeviceMotionHandler) {
        if !self.isAccelerometerAvailable {
            debugPrint("Accelerometer is not available")
        } else {
            super.deviceMotionUpdateInterval = interval
            super.startDeviceMotionUpdates(to: motionQueue, withHandler: handler)
        }
    }
}

