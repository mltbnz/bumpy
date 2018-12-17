//
//  MapControllerServices.swift
//  bumpy
//
//  Created by Malte Bünz on 14.12.18.
//  Copyright © 2018 mbnz. All rights reserved.
//

import Foundation

struct MapControllerServices {
    let bumpyController: BumpyController
}

extension MapControllerServices {
    init(with locationProvider: LocationProviding = LocationProvider(),
         motionDataProvider: MotionDataProvider = MotionDataProvider(motionManager: MotionDataManager())) {
        bumpyController = BumpyController(locationProvider: locationProvider,
                                          motionManager: motionDataProvider)
    }
}
