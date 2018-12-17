//
//  LocationFetcherType.swift
//  bumpy
//
//  Created by Malte Bünz on 03.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import CoreLocation

protocol LocationFetcherType {
    var locationFetcherDelegate: LocationFetcherDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var pausesLocationUpdatesAutomatically: Bool { get set }
    var allowsBackgroundLocationUpdates: Bool { get set }
    var distanceFilter: CLLocationDistance { get set }
    
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    
    func locationServicesEnabled() -> Bool
    func authorizationStatus() -> CLAuthorizationStatus
}

extension CLLocationManager: LocationFetcherType {
    func locationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    var locationFetcherDelegate: LocationFetcherDelegate? {
        get { return delegate as? LocationFetcherDelegate }
        set { delegate = newValue as? CLLocationManagerDelegate }
    }
}
