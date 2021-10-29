//
//  StudentRequests.swift
//  ParentDriver
//
//  Created by Pavel Reva on 29.10.2021.
//

import Foundation
import Repository

struct StudentRequests {
    static func findStudent(studentName: String) -> RequestProvider {
        let query = ["stuName": studentName]
        return Request(method: .post, path: API.Student.findStudent, query: query)
    }
}
