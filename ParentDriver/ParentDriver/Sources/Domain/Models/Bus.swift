//
//  Bus.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import ObjectMapper

 class Bus: Mappable {
    
     var trackerId: String = ""
     var trackerName: String = ""
     var imei: String = ""
     var seat: String = ""
     var integrationId: [String] = []
     
    // MARK: - Mappable
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        trackerId <- map["trackerId"]
        trackerName <- map["trackerName"]
        imei <- map["IMEI"]
        seat <- map["Seat"]
        integrationId <- map["integrationId"]
    }
}
