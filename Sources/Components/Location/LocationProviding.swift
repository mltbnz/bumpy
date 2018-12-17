//
//  LocationProviding.swift
//  bumpy
//
//  Created by Malte Bünz on 14.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import CoreLocation

protocol LocationProviding {
    var isAuthorized: AuthorizationObserver { get }
    var userLocation: LocationObserver { get }
    
    var locationFetcher: LocationFetcherType { get }
    
    func requestAuthorization(for type: AuthorizationType)
    func startTrackingLocation(allowsBackgroundLocation: Bool)
    func stopTrackingLocation()
}
