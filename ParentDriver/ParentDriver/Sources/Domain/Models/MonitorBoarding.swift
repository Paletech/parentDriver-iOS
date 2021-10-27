//
//  MonitorBoarding.swift
//  ParentDriver
//
//  Created by Pavel Reva on 26.10.2021.
//

import ObjectMapper

class MonitorBoarding: Mappable {
    
    var studentName: String = ""
    var alert: String = ""
    var time: String = ""
    
    // MARK: - Mappable
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        studentName <- map["studentName"]
        alert <- map["alert"]
        time <- map["time"]
    }
}
