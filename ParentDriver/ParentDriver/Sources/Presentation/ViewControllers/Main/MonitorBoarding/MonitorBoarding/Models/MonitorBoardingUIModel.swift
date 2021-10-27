//
//  MonitorBoardingUIModel.swift
//  ParentDriver
//
//  Created by Pavel Reva on 27.10.2021.
//

import UIKit

struct MonitorBoardingUIModel {

    let student: String
    let time: String
    let status: String
    let image: UIImage?
    
    init(status: MonitorBoarding) {
        self.student = status.studentName
        self.time = status.time
        self.status = status.alert
        self.image = status.status.image
    }
}
