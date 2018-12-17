//
//	GPSVehicleKit
//
//	Copyright (C) 2018 DB Systel GmbH
//

import CoreLocation

public typealias LocationHandler = (CLLocation) -> Swift.Void
public typealias LocationObserver = Observable<CLLocation?>

public typealias AuthorizationHandler = (Bool) -> Swift.Void
public typealias AuthorizationObserver = Observable<Bool>

/// Permission types to use location services.
///
/// - whenInUse: While the app is in the foreground.
/// - always: Whenever the app is running.
public enum AuthorizationType {
    case whenInUse, always
}
