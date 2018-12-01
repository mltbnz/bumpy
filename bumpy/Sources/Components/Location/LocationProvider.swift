//
//  LocationManager.swift
//  bumpy
//
//  Created by Malte Bünz on 06.11.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import CoreLocation

class LocationProvider: NSObject {
    public var locationFetcher: LocationFetcher
    public let currentLocation: Observable<CLLocation?>
    fileprivate var isAuthorized: Bool?
    
    init(locationFetcher: LocationFetcher = CLLocationManager()) {
        self.locationFetcher = locationFetcher
        self.currentLocation = Observable(nil)
        super.init()
        self.locationFetcher.locationFetcherDelegate = self
        self.locationFetcher.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    public func requestAuthorization() {
        locationFetcher.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        guard let isAuthorized = self.isAuthorized else {
            return
        }
        if isAuthorized {
            locationFetcher.startUpdatingLocation()
        }
    }
}

extension LocationProvider: LocationFetcherDelegate {
    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]?) {
        guard let locations = locations, let currentLocation = locations.first else {
            return
        }
        self.currentLocation.value = currentLocation
    }
    
    func locationFetcher(_ fetcher: LocationFetcher, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .restricted:
            self.isAuthorized = true
        case .denied, .notDetermined:
            self.isAuthorized = false
        }
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
