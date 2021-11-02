//
//  RidersheepChanges.swift
//  ParentDriver
//
//  Created by Машенька on 31/10/2021.
//

import ObjectMapper

import Foundation

class RidersheepChanges: Mappable {

    var student: String = ""
    var address: String = ""
    var campus: String = ""

    // MARK: - Mappable

    required init?(map: Map) { }

    func mapping(map: Map) {
        student <- map["student"]
        address <- map["address"]
        campus <- map["campus"]
    }
}
