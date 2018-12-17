//
//  LocationFetcherTest.swift
//  bumpyTests
//
//  Created by Malte Bünz on 17.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import XCTest
import CoreLocation
@testable import bumpy

class LocationFetcherTest: XCTestCase {
    
    var sut: MockLocationFetcher!
    
    override func setUp() {
        super.setUp()
        sut = MockLocationFetcher()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_shouldReturnNilForRequestHandleCallback_whenProviderStopsLocationTracking() {
        // given
        let locationProvider = LocationProvider(locationFetcher: self.sut)
        // when
        locationProvider.startTrackingLocation(allowsBackgroundLocation: true)
        locationProvider.stopTrackingLocation()
        // then
        XCTAssertNil(sut.handleRequestLocation)
    }
}
