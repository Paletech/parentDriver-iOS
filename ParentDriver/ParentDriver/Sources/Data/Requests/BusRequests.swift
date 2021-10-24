//
//  BusRequests.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import Foundation
import Repository

struct BusRequests {
    static func getAllBuses() -> RequestProvider {
        return Request(method: .post, path: API.Bus.get)
    }
}
