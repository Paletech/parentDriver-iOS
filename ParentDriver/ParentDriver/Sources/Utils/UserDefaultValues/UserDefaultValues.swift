//
//  UserDefaultValues.swift
//  CathNow
//
//  Created by Pavlo Reva on 06/07/2020.
//  Copyright © 2020 Coloplast. All rights reserved.
//

import Foundation

class UserDefaultValues {

    private struct Keys {
        static let isLaunchSreenShown = "isLaunchSreenShown"
    }
    
    @UserDefault(Keys.isLaunchSreenShown, defaultValue: false)
    static var isLaunchSreenShown: Bool
    
    static func clear() {
        
    }
}
