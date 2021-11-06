import CoreLocation

class LocationRepository: NSObject {

    var currentLocation: CLLocation? {
        locationManager.location
    }
    
    private let locationManager: CLLocationManager

    private let desiredAccuracy = kCLLocationAccuracyHundredMeters
    private let notification = NotificationCenter.default
    private let validStatuses: [CLAuthorizationStatus] = [.authorizedWhenInUse, .authorizedAlways]
    
    private var completionHandlers: [((Result<CLLocation, Error>) -> Void)] = []
    private var permissionCompletionHandler: ((Result<Void, Error>) -> Void)?
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        initializeTheLocationManager()
    }

    func stopUpdate() {
        locationManager.stopUpdatingLocation()
    }
    
    func update(_ completionHandler: @escaping (Result<CLLocation, Error>) -> Void) {
        guard isLocationServicesEnabled() else {
            completionHandler(.failure(LocationError.locationNotPermitted))
            return
        }
        
        guard isAuthorizationStatusValid() else {
            completionHandler(.failure(LocationError.locationNotPermitted))
            return
        }
        
        self.completionHandlers.append(completionHandler)
        
        locationManager.startUpdatingLocation()
    }
    
    func backgroundUpdate(_ completionHandler: @escaping (Result<CLLocation, Error>) -> Void) {
        guard isLocationServicesEnabled() else {
            completionHandler(.failure(LocationError.locationNotPermitted))
            return
        }
        
        guard isAuthorizationStatusValid() else {
            completionHandler(.failure(LocationError.locationNotPermitted))
            return
        }
        
        self.completionHandlers.append(completionHandler)

        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    
    private func initializeTheLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
    }

    func isLocationServicesEnabled() -> Bool {
        CLLocationManager.locationServicesEnabled()
    }

    func isAuthorizationStatusValid() -> Bool {
        validStatuses.contains(CLLocationManager.authorizationStatus())
    }
    
    func isDeniedAuthorization() -> Bool {
        CLLocationManager.authorizationStatus() == .denied
    }
    
    func isNotDeterminedAuthorization() -> Bool {
        CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    func getPermission(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        permissionCompletionHandler = completionHandler
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationRepository: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, location.isValid {
            completionHandlers.forEach { $0(.success(location))}
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            manager.stopUpdatingLocation()
            return
        }
        completionHandlers.forEach { $0(.failure(error))}
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if validStatuses.contains(status) {
            permissionCompletionHandler?(.success(()))
        } else {
            permissionCompletionHandler?(.failure(LocationError.locationNotPermitted))
        }
    }
}
