//
//	GPSVehicleKit
//
//	Copyright (C) 2018 DB Systel GmbH
//

import CoreLocation

public extension CLAuthorizationStatus {
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .notDetermined, .restricted:
            return false
        }
    }
}
