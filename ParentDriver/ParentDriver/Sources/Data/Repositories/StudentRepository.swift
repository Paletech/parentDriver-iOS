//
//  StudentRepository.swift
//  ParentDriver
//
//  Created by Pavel Reva on 29.10.2021.
//

import Repository
import ObjectMapper
import Foundation
import Combine

enum StudentErrors: Error {
    case noBusSelected
}

struct StudentRepository: Repository {

    private struct Keys {
        static let studentsKey = "student"
    }
    
    let remote: RemoteStoreMappable<Student>
    let local: KeycheinStore<Bus>

    // MARK: - Fabric method
    
    static func `default`() -> StudentRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return StudentRepository(remote: RemoteStoreMappable(session: session, handler: handler), local: inject())
    }

    // MARK: - Network
    
    func findStudent(studentName: String) -> AnyPublisher<[Student], Error> {
        remote.requestArray(request: StudentRequests.findStudent(studentName: studentName),
                            keyPath: Keys.studentsKey)
    }
    
    func addStudent(studentId: String,
                    coordinates: String) -> AnyPublisher<Any, Error> {
        guard let bus = try? self.local.get(from: KeychainKeys.selectedBus.rawValue) else { return Fail<Any, Error>(error: StudentErrors.noBusSelected).eraseToAnyPublisher() }

        return remote.requestJSON(request: StudentRequests.addStudent(studentId: studentId,
                                                                      busId: bus.trackerId,
                                                               coordinates: coordinates))
    }
}

