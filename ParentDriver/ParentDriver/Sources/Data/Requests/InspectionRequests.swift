//
//  InspectionRequests.swift
//  ParentDriver
//
//  Created by Pavel Reva on 07.11.2021.
//

import Foundation
import Repository

struct InspectionRequests {
    static func getInspection() -> Request {
        return Request(method: .post, path: API.Inspection.get)
    }
    
    static func submitInspection(inspectionSubmition: InspectionSubmitionModel) -> Request {
        return Request(method: .post, path: API.Inspection.get, query: inspectionSubmition.toQuery)
    }
}
