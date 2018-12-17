import CoreMotion

protocol MotionManaging {
    var isAccelerometerAvailable: Bool { get }
    var isDeviceMotionAvailable: Bool { get }
    var accelerometerUpdateInterval: TimeInterval { get set }
    var deviceMotionUpdateInterval: TimeInterval { get set }
    
    func startAccelerometerUpdates()
    func startAccelerometerUpdates(to queue: OperationQueue, withHandler handler: @escaping CMAccelerometerHandler)
    
    func startDeviceMotionUpdates()
    func startDeviceMotionUpdates(to queue: OperationQueue, withHandler handler: @escaping CMDeviceMotionHandler)
    
    func stopDeviceMotionUpdates()
    func stopAccelerometerUpdates()
}

extension CMMotionManager: MotionManaging {}
