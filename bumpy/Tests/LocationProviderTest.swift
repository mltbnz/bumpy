//
//  LocationProviderTest.swift
//  bumpyTests
//
//  Created by Malte Bünz on 01.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import XCTest
import CoreLocation
@testable import bumpy

class GVKCurrentLocationProvider: XCTestCase {
    
    struct MockLocationFetcher: LocationFetcher {
        weak var locationFetcherDelegate: LocationFetcherDelegate?
        var desiredAccuracy: CLLocationAccuracy = 0
        
        func requestLocation() {
            
        }
        func requestWhenInUseAuthorization() {
        }
    }
    
    var sut: LocationProvider!
    
    override func setUp() {
        super.setUp()
        let locationFetcher = MockLocationFetcher()
        self.sut = LocationProvider(locationFetcher: locationFetcher)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLocationManager_IsSet_isNotNil() {
        XCTAssertNotNil(sut.locationFetcher)
    }
    
    func testLocationManagerDelegate_IsSet_isNotNil() {
        XCTAssertNotNil(sut.locationFetcher.locationFetcherDelegate)
    }
    
    func testLocationManagerDelegate_IsOfTypeCLLocationManagerDelegate_True() {
        XCTAssertNotNil(sut.locationFetcher.locationFetcherDelegate as? LocationProvider)
    }
}

