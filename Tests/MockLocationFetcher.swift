import Foundation
@testable import bumpy
import CoreLocation

class MockLocationFetcher: LocationFetcherType {
    weak var locationFetcherDelegate: LocationFetcherDelegate?
    var pausesLocationUpdatesAutomatically: Bool = false
    var desiredAccuracy: CLLocationAccuracy = 0
    var allowsBackgroundLocationUpdates: Bool = true
    var distanceFilter: CLLocationDistance = 250
    
    var handleRequestLocation: (() -> CLLocation)?
    func requestLocation() {
        guard let location = handleRequestLocation?() else {
            return
        }
        locationFetcherDelegate?.locationFetcher(self, didUpdateLocations: [location])
    }
    
    var handleAuthorizationRequest: (() -> CLAuthorizationStatus)?
    func requestWhenInUseAuthorization() {
        guard let authorization = handleAuthorizationRequest?() else {
            return
        }
        locationFetcherDelegate?.locationFetcher(self, didChangeAuthorization: authorization)
    }
    
    func requestAlwaysAuthorization() {
        guard let authorization = handleAuthorizationRequest?() else {
            return
        }
        locationFetcherDelegate?.locationFetcher(self, didChangeAuthorization: authorization)
    }
    
    func startUpdatingLocation() {
        guard let location = handleRequestLocation?() else {
            return
        }
        locationFetcherDelegate?.locationFetcher(self, didUpdateLocations: [location])
    }
    
    func stopUpdatingLocation() {
        self.handleRequestLocation = nil
    }
    
    func locationServicesEnabled() -> Bool {
        return true
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }
}
