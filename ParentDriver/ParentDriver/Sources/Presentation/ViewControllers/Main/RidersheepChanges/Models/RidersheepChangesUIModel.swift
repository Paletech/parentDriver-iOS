//
//  RidersheepChangesUIModel.swift
//  ParentDriver
//
//  Created by Машенька on 31/10/2021.
//

import Foundation

struct RidersheepChangesUIModel {

    let student: String
    let campus: String
    let address: String

    init(data: RidersheepChanges) {
        self.student = data.student
        self.address = data.address
        self.campus = data.campus
    }
}
