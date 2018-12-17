import CoreMotion

class MotionDataProvider {
    // MARK: - Public
    public var accelerometerData: Observable<CMAccelerometerData?>
    public var motionData: Observable<CMDeviceMotion?>
    // MARK: - Private
    private let motionManager: MotionManaging
    private lazy var accelerometerQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Motion queue"
        return queue
    }()
    private lazy var motionQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Motion queue"
        return queue
    }()
    
    
    init(motionManager: MotionManaging) {
        self.motionManager = motionManager
        self.accelerometerData = Observable(nil)
        self.motionData = Observable(nil)
    }
    
    public func startAccelelometerUpdates() {
        motionManager.startAccelerometerUpdates(to: self.accelerometerQueue) { [weak self] (accelerometerData, error) in
            self?.accelerometerData.value = accelerometerData
        }
    }
    
    public func startDeviceMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: self.motionQueue) { [weak self] (motionData, error) in
            self?.motionData.value = motionData
        }
    }
}
