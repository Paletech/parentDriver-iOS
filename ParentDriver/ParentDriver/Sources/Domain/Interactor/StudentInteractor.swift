//
//  StudentInteractor.swift
//  ParentDriver
//
//  Created by Pavel Reva on 29.10.2021.
//

import Combine

class StudentInteractor: Interactor {
    
    struct Dependencies {
        let repo: StudentRepository
    }
    
    let dp: Dependencies
    
    // MARK: - Init/Deinit
    
    init(dp: Dependencies) {
        self.dp = dp
    }
    
    // MARK: - Network
    
    func findStudent(studentName: String) -> AnyPublisher<[Student], Error> {
        dp.repo.findStudent(studentName: studentName)
    }
}
