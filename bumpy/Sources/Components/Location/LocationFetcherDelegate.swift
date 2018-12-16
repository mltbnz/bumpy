//
//  LocationFetcherDelegate.swift
//  bumpy
//
//  Created by Malte Bünz on 03.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import CoreLocation

protocol LocationFetcherDelegate: class {
    func locationFetcher(_ fetcher: LocationFetcherType, didUpdateLocations locations: [CLLocation]?)
    func locationFetcher(_ fetcher: LocationFetcherType, didChangeAuthorization status: CLAuthorizationStatus)
}
