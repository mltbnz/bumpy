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
    
    private var locationFetcher: MockLocationFetcher!
    var sut: LocationProviding!
    
    override func setUp() {
        super.setUp()
        locationFetcher = MockLocationFetcher()
    }
    
    override func tearDown() {
        locationFetcher = nil
        sut = nil
        super.tearDown()
    }
    
    func test_shouldSetLocationfetcher_returnsFetcher_when_providerIsCreated() {
        // given
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // then
        XCTAssertNotNil(sut.locationFetcher)
    }
    
    func test_shouldSetLocationfetcherDelegate_returnsValue_when_providerIsCreated() {
        // given
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // then
        XCTAssertNotNil(sut.locationFetcher.locationFetcherDelegate)
    }
    
    func test_shouldSetDelegate_isLocationProvider_when_() {
        // given
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // then
        XCTAssertNotNil(sut.locationFetcher.locationFetcherDelegate as? LocationProvider)
    }
    
    func test_shouldHaveDefaultDistanceFilter_whenProviderIsCreated() {
        // given
        let distanceFilter: CLLocationDistance = 250.0
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // then
        XCTAssertEqual(distanceFilter, sut.locationFetcher.distanceFilter)
    }
    
    func test_shouldPausesLocationUpdatesAutomatically_whenProviderIsCreated() {
        // given
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // then
        XCTAssertTrue(sut.locationFetcher.allowsBackgroundLocationUpdates)
    }
    
    func test_shouldSetCustomAccuracy_whenInjectedIntoInitializer() {
        // given
        let accuracy = kCLLocationAccuracyNearestTenMeters
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // then
        XCTAssertEqual(accuracy, sut.locationFetcher.desiredAccuracy)
    }
    
    func test_shouldSetNewValue_whenAllowsBackgroundLocationUpdatesIsSet() {
        // given
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        // when
        sut.startTrackingLocation(allowsBackgroundLocation: true)
        // then
        XCTAssertTrue(sut.locationFetcher.allowsBackgroundLocationUpdates)
    }
    
    func test_shouldReturnIsAuthorized_whenRequestWhenInUseAuthorization() {
        // given
        let requestAuthorizationExpectation = expectation(description: "authorization request")
        // when
        locationFetcher.handleAuthorizationRequest = {
            requestAuthorizationExpectation.fulfill()
            return .authorizedWhenInUse
        }
        sut = LocationProvider(locationFetcher: locationFetcher)
        sut.requestAuthorization(for: .whenInUse)
        // then
        XCTAssertTrue(locationFetcher.authorizationStatus().isAuthorized)
        wait(for: [requestAuthorizationExpectation], timeout: 1)
    }
    
    func test_shouldReturnIsAuthorized_whenrequestAlwaysAuthorization() {
        // given
        let requestAuthorizationExpectation = expectation(description: "authorization request")
        locationFetcher.handleAuthorizationRequest = {
            requestAuthorizationExpectation.fulfill()
            return .authorizedAlways
        }
        sut = LocationProvider(locationFetcher: locationFetcher)
        let observerExspectation = expectation(description: "observer")
        sut.isAuthorized.addObserver(self) { (isAuthorized, _) in
            observerExspectation.fulfill()
            XCTAssertTrue(isAuthorized)
        }
        // when
        sut.requestAuthorization(for: .always)
        // then
        wait(for: [requestAuthorizationExpectation, observerExspectation], timeout: 1)
    }
    
    func test_shouldReturnLocationUpdate_whenStartTrackingLocation() {
        // given
        let requestAuthorizationExpectation = expectation(description: "authorization request")
        let mockLocations = [
            CLLocation(latitude: 37.3393, longitude: -121.8993),
            CLLocation(latitude: 37.3293, longitude: -121.8893)
        ]
        locationFetcher.handleAuthorizationRequest = {
            requestAuthorizationExpectation.fulfill()
            return .authorizedWhenInUse
        }
        let requestLocationExpectation = expectation(description: "request location")
        locationFetcher.handleRequestLocation = {
            requestLocationExpectation.fulfill()
            return mockLocations[0]
        }
        sut = LocationProvider(locationFetcher: self.locationFetcher)
        let observerExspectation = expectation(description: "observer")
        sut.userLocation.addObserver(self) { (location, _) in
            observerExspectation.fulfill()
            XCTAssertNotNil(location)
        }
        // when
        sut.requestAuthorization(for: .whenInUse)
        sut.startTrackingLocation(allowsBackgroundLocation: true)
        // then
        wait(for: [requestLocationExpectation, requestAuthorizationExpectation, observerExspectation], timeout: 2)
    }
}

