//
//  Student.swift
//  ParentDriver
//
//  Created by Pavel Reva on 29.10.2021.
//

import Foundation
import ObjectMapper

class Student: Mappable {
    
    var id: String = ""
    var name: String = ""
    
   // MARK: - Mappable
   
   required init?(map: Map) { }
   
   func mapping(map: Map) {
       id <- map["studentID"]
       name <- map["name"]
   }
}
