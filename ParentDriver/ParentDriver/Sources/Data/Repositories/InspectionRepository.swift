//
//  InspectionReposutory.swift
//  ParentDriver
//
//  Created by Pavel Reva on 07.11.2021.
//

import Repository
import ObjectMapper
import Foundation
import Combine

enum InspectionErrors: Error {
    case noBusSelected
}

struct InspectionRepository: Repository {

    private struct Keys {
        static let inspectionKey = "inspItem"
    }
    
    let remote: RemoteStoreMappable<InspectionItemResponse>
    let busLocalStore: KeycheinStore<Bus>
    let tokenLocalStore: KeycheinStore<Token>

    // MARK: - Fabric method
    
    static func `default`() -> InspectionRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return InspectionRepository(remote: RemoteStoreMappable(session: session, handler: handler),
                                    busLocalStore: inject(),
                                    tokenLocalStore: inject())
    }

    // MARK: - Network
    
    func getInspection() -> AnyPublisher<[InspectionItemResponse], Error> {
        return remote.requestArray(request: InspectionRequests.getInspection(),
                            keyPath: Keys.inspectionKey)
    }
    
    func submitInspection(inspectionSubmition: InspectionSubmitionModel) -> AnyPublisher<Any, Error> {
        return remote.requestJSON(request: InspectionRequests.submitInspection(inspectionSubmition: inspectionSubmition))
    }
    
    // MARK: - Local
    
    func getSelectedBus() -> Bus? {
        try? busLocalStore.get(from: KeychainKeys.selectedBus.rawValue)
    }
    
    func getLocalDbId() -> String? {
        try? tokenLocalStore.get(from: KeychainKeys.token.rawValue).dbId
    }
}
