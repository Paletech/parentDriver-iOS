//
//  MonitorBoardingRequests.swift
//  ParentDriver
//
//  Created by Pavel Reva on 26.10.2021.
//

import Foundation
import Repository

struct MonitorBoardingRequests {
    static func getAll(trackerId: String, interval: String) -> RequestProvider {
        let query = ["trackerID": trackerId, "interval": interval]
        return Request(method: .post, path: API.MonitorBoarding.get, query: query)
    }
}
