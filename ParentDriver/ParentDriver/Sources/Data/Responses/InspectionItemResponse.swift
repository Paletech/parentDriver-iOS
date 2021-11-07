//
//  IspectionItem.swift
//  ParentDriver
//
//  Created by Pavel Reva on 07.11.2021.
//

/*
 "inspItem":[
 {"itemID":"16",
 "itemName":"Clearance Lights - Front", "loc":"Exterior-Front"},
 {"itemID":"15", "itemName":"Headlights", "loc":"Exterior-Front"},
 ....
 ]
 */

import ObjectMapper

class InspectionItemResponse: Mappable {
    
    var id: String = ""
    var name: String = ""
    var loc: String = ""
    
    // MARK: - Mappable
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["itemID"]
        name <- map["itemName"]
        loc <- map["loc"]
    }
}
