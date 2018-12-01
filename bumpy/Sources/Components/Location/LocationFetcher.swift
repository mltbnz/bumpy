//
//  LocationFetcher.swift
//  bumpy
//
//  Created by Malte Bünz on 01.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import CoreLocation

protocol LocationFetcherDelegate: class {
    func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]?)
    func locationFetcher(_ fetcher: LocationFetcher, didChangeAuthorization status: CLAuthorizationStatus)
}

protocol LocationFetcher {
    var locationFetcherDelegate: LocationFetcherDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    
    func requestLocation()
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationFetcher {

    var locationFetcherDelegate: LocationFetcherDelegate? {
        get { return delegate as? LocationFetcherDelegate }
        set { delegate = newValue as? CLLocationManagerDelegate }
    }    
}

extension CLAuthorizationStatus {
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .notDetermined, .restricted:
            return false
        }
    }
}
