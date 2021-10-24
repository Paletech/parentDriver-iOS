//
//  User.swift
//  ParentDriver
//
//  Created by Pavel Reva on 24.10.2021.
//

import ObjectMapper

class User: Mappable {
    
    var dbId: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var timeZone: String = ""
    var forceLoc: String = ""
    
    // MARK: - Mappable
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        dbId <- map["driverDBID"]
        firstName <- map["f_name"]
        lastName <- map["l_name"]
        timeZone <- map["timezone"]
        forceLoc <- map["forceLoc"]
    }
}
