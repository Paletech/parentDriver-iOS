//
//  AuthResponse.swift
//  ParentDriver
//
//  Created by Pavel Reva on 24.10.2021.
//

import ObjectMapper

class AuthResponse: Mappable {
    
    var token: String = ""
    var user: User?
    
    // MARK: - Mappable
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        token <- map["auth_token"]
        user <- map["user"]
    }
}
