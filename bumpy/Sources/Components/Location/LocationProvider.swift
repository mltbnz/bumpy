//
//  LocationManager.swift
//  bumpy
//
//  Created by Malte Bünz on 06.11.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import CoreLocation

class LocationProvider: NSObject, LocationProviding {
    public var locationFetcher: LocationFetcherType
    public var isAuthorized: AuthorizationObserver
    public var userLocation: LocationObserver
    
    init(locationFetcher: LocationFetcherType = CLLocationManager()) {
        self.locationFetcher = locationFetcher
        self.userLocation = Observable(nil)
        self.isAuthorized = Observable(false)
        super.init()
        self.locationFetcher.locationFetcherDelegate = self
        self.locationFetcher.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestAuthorization(for type: AuthorizationType = .whenInUse) {
        // Request appropiate authorization
        switch type {
        case .whenInUse:
            locationFetcher.requestWhenInUseAuthorization()
        case .always:
            locationFetcher.requestAlwaysAuthorization()
        }
    }
    
    /// Starts the generation of updates that report the user’s current location.
    func startTrackingLocation(allowsBackgroundLocation: Bool) {
        locationFetcher.allowsBackgroundLocationUpdates = allowsBackgroundLocation
        locationFetcher.startUpdatingLocation()
    }
    
    /// Stops the generation of location updates.
    func stopTrackingLocation() {
        locationFetcher.allowsBackgroundLocationUpdates = false
        locationFetcher.stopUpdatingLocation()
    }
}

extension LocationProvider: LocationFetcherDelegate {
    func locationFetcher(_ fetcher: LocationFetcherType, didUpdateLocations locations: [CLLocation]?) {
        guard let locations = locations, let currentLocation = locations.first else {
            return
        }
        userLocation.value = currentLocation
    }
    
    func locationFetcher(_ fetcher: LocationFetcherType, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status != .notDetermined else {
            return
        }
        isAuthorized.value = status.isAuthorized
    }
}

extension LocationProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationFetcher(manager, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationFetcher(manager, didChangeAuthorization: status)
    }
}
