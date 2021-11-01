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

    required init?(map: Map) { }

    func mapping(map: Map) {
        student <- map["student"]
        address <- map["address"]
    }
}
