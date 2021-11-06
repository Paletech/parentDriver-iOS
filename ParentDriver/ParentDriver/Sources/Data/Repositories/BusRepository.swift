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

struct BusRepository: Repository, Syncable {

    private struct Keys {
        static let trackerKey = "tracker"
    }
    
    let remote: RemoteStoreMappable<Bus>
    let local: KeycheinStore<Bus>

    // MARK: - Fabric method
    
    static func `default`() -> BusRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return BusRepository(remote: RemoteStoreMappable(session: session, handler: handler),
                              local: inject())
    }

    // MARK: - Network
    
    func getAllBuses() -> AnyPublisher<[Bus], Error> {
        remote.requestArray(request: BusRequests.getAllBuses(), keyPath: Keys.trackerKey)
    }
    
    // MARK: - Local
    
    func saveBusSelection(_ bus: Bus) {
        try? local.save(bus, at: KeychainKeys.selectedBus.rawValue)
    }
    
    func getBusSelection() -> Bus? {
        try? local.get(from: KeychainKeys.selectedBus.rawValue)
    }

    func removeBusSelection() {
        try? local.remove(from: KeychainKeys.selectedBus.rawValue)
    }
}
