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
        return Request(method: .post, path: API.Inspection.submit, query: ArrayURLCompose(builder: inspectionSubmition))
    }
}



class ArrayURLCompose: URLComposer {
    
    let submitionModel: InspectionSubmitionModel
    
    init(builder: InspectionSubmitionModel) {
        self.submitionModel = builder
    }
    
    func compose(into url: URL) throws -> URL {
        var result = url
        
        submitionModel.toQuery.forEach { (key: String, value: Any) in
            if let value = value as? [String] {
                value.forEach {
                    result = result.appending(key, value: $0)
                }
            } else if let value = value as? String {
                result = result.appending(key, value: value)
            }
        }
        
        return result
    }
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}
