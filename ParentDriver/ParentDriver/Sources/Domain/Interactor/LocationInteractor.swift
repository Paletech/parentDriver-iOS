import UIKit
import Combine
import CoreLocation

enum LocationError: Error {
    case locationNotPermitted
}

class LocationInteractor: Interactor {
    
    struct Dependencies {
        let location: LocationRepository
    }

    let dp: Dependencies

    init(dependencies: Dependencies) {
        self.dp = dependencies
    }
    
    func getLocation() -> AnyPublisher<CLLocation, Error> {
        Future { promise in
            if self.dp.location.isLocationServicesEnabled() == false {
                promise(.failure(LocationError.locationNotPermitted))
            } else {
                self.dp.location.update { result in
                    switch result {
                    case .success(let location):
                        promise(.success(location))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                    self.dp.location.stopUpdate()
                }
            }
        }.eraseToAnyPublisher()
    }
        
    func getAccess() -> AnyPublisher<Void, Error> {
        Future { promise in

            if self.dp.location.isLocationServicesEnabled() == false {
                promise(.failure(LocationError
                                    .locationNotPermitted))
            } else if self.dp.location.isNotDeterminedAuthorization() {
                self.dp.location.getPermission(completionHandler: { result in
                    switch result {
                    case .success:
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                })
            } else if self.dp.location.isAuthorizationStatusValid() {
                promise(.success(()))
            } else {
                promise(.failure(LocationError.locationNotPermitted))
            }
        }.eraseToAnyPublisher()
    }
    
    func getCurrentLocation() -> CLLocation? {
        self.dp.location.currentLocation
    }
    
    func listenLocation() -> AnyPublisher<CLLocation, Never> {
        let subject = PassthroughSubject<CLLocation, Never>()
        dp.location.update { result in
            switch result {
            case .success(let location):
                subject.send(location)
            case .failure(let error):
                print(error)
            }
        }
        return subject.eraseToAnyPublisher()
    }
}
