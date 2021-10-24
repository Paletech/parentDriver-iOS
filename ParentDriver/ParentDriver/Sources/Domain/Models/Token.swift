//
//  Token.swift
//  ParentDriver
//
//  Created by Pavel Reva on 21.10.2021.
//

import ObjectMapper

class Token: Mappable {
    var accessToken: String?
    
    required public init?(map: Map) {}
    init() { }

    public func mapping(map: Map) {
        accessToken <- map["accessToken"]
    }
}
