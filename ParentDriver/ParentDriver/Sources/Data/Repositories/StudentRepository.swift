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

struct StudentRepository: Repository {

    private struct Keys {
        static let studentsKey = "student"
    }
    
    let remote: RemoteStoreMappable<Student>

    // MARK: - Fabric method
    
    static func `default`() -> StudentRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return StudentRepository(remote: RemoteStoreMappable(session: session, handler: handler))
    }

    // MARK: - Network
    
    func findStudent(studentName: String) -> AnyPublisher<[Student], Error> {
        remote.requestArray(request: StudentRequests.findStudent(studentName: studentName),
                            keyPath: Keys.studentsKey)
    }
}

