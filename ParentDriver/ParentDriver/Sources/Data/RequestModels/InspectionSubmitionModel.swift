//
//  InspectionSubmitionModel.swift
//  ParentDriver
//
//  Created by Pavel Reva on 07.11.2021.
//

import Foundation

private struct Constants {
    static let passedStatus = "PASS"
    static let failedStatus = "FAIL"
}

enum InspectionStatus {
    case pass
    case fail
    
    var requestValue: String {
        switch self {
        case .pass:
            return Constants.passedStatus
        case .fail:
            return Constants.failedStatus
        }
    }
}

struct InspectionSubmitionModel {
    let trackerImei: String
    let inspectionType: BusInspectionType
    let failedItems: [String]
    let kidCheck: String = "1"
    let inspectionStatus: InspectionStatus
    let comments: String?
    var location: String = ""
    
    var toQuery: [String: String] {
        var data = ["trackerIMEI": trackerImei,
                "inspType": inspectionType.title.uppercased(),
                "failedItem": failedItems.joined(separator: ","),
                "kidCheck": kidCheck,
                "inspStatus": inspectionStatus.requestValue,
                "inspLatLng": location]
        
        comments.flatMap {
            data["comments"] = $0
        }
        
        return data
    }
}
