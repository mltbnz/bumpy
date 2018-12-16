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
    
    class MockLocationFetcher: LocationFetcherType {
        
        weak var locationFetcherDelegate: LocationFetcherDelegate?
        var desiredAccuracy: CLLocationAccuracy = 0

        func requestWhenInUseAuthorization() {}
        func startUpdatingLocation() {}
        func stopUpdatingLocation() {}
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
    
    func test_shouldSetLocationfetcher_returnsFetcher_when_providerIsCreated() {
        XCTAssertNotNil(sut.locationFetcher)
    }
    
    func test_shouldSetLocationfetcherDelegate_returnsValue_when_providerIsCreated() {
        XCTAssertNotNil(sut.locationFetcher.locationFetcherDelegate)
    }
    
    func test_shouldSetDelegate_isLocationProvider_when_() {
        XCTAssertNotNil(sut.locationFetcher.locationFetcherDelegate as? LocationProvider)
    }
}

