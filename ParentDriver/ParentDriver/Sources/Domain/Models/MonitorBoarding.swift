//
//  MonitorBoarding.swift
//  ParentDriver
//
//  Created by Pavel Reva on 26.10.2021.
//

import ObjectMapper
import UIKit

private struct Constants {
    static let processingKey = "Processing"
    static let emptyScan = ""
}

enum MonitorBoardingSatus {
    case good
    case processing
    case bad
    
    var image: UIImage? {
        switch self {
        case .bad:
            return R.image.ic_status_bad()?.withTintColor(.red)
        case .processing:
            return R.image.ic_status_processing()?.withTintColor(.gray)
        case .good:
            return R.image.ic_status_good()?.withTintColor(.green)
        }
    }
}

class MonitorBoarding: Mappable {
    
    var studentName: String = ""
    var alert: String = ""
    var time: String = ""
    
    var status: MonitorBoardingSatus {
        switch alert {
        case Constants.processingKey:
            return .processing
        case Constants.emptyScan:
            return .good
        default:
            return .bad
        }
    }
    
    // MARK: - Mappable
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        studentName <- map["studentName"]
        alert <- map["alert"]
        time <- map["time"]
    }
}
