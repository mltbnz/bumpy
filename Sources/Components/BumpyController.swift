import Foundation

public class Observer {}

class BumpyController {
    private let locationProvider: LocationProviding
    private let motionManager: MotionDataProvider
    
    init(locationProvider: LocationProviding, motionManager: MotionDataProvider) {
        self.motionManager = motionManager
        self.locationProvider = locationProvider
    }
    
    public func start() {
        locationProvider.requestAuthorization(for: .whenInUse)
        locationProvider.startTrackingLocation(allowsBackgroundLocation: true)
        locationProvider.isAuthorized.addObserver(self) { (isAuthorized, options) in
            print(isAuthorized)
            print(options)
        }
        locationProvider.userLocation.addObserver(self) { (location, options) in
            print(location ?? "Location")
            print(options)
        }
        
        motionManager.startAccelelometerUpdates()
        motionManager.accelerometerData.addObserver(self) { (data, options) in
            print(data ?? "Motion")
            print(options)
        }
    }
}
