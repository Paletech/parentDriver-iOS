//
//  Coloplast+UserDefaults.swift
//  CathNow
//
//  Created by Pavlo Reva on 06/07/2020.
//  Copyright © 2020 Coloplast. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
struct NullableUserDefault<T> {
    let key: String

    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
