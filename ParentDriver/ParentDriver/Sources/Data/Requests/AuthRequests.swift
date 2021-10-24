//
//  AuthRequests.swift
//  ParentDriver
//
//  Created by Pavel Reva on 24.10.2021.
//

import Foundation
import Repository

struct AuthRequests {
    static func signInRequest(driverId: String,
                              password: String,
                              schoolId: String) -> RequestProvider {
        let body = ["driver_id": driverId,
                    "password": password,
                    "co_id": schoolId] 
        
        return Request(method: .post, path: API.Auth.login, query: body)
    }
}
