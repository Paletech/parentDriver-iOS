//
//  BusRepository.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import Repository
import ObjectMapper
import Foundation
import Combine

struct MonitorBoardingRepository: Repository, Syncable {

    private struct Keys {
        static let monitorBoardingKey = "student"
    }
    
    let remote: RemoteStoreMappable<MonitorBoarding>

    // MARK: - Fabric method
    
    static func `default`() -> MonitorBoardingRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return MonitorBoardingRepository(remote: RemoteStoreMappable(session: session, handler: handler))
    }

    // MARK: - Network
    
    func getAll(trackerId: String, interval: String) -> AnyPublisher<[MonitorBoarding], Error> {
        remote.requestArray(request: MonitorBoardingRequests.getAll(trackerId: trackerId,
                                                                    interval: interval),
                            keyPath: Keys.monitorBoardingKey)
    }
}
