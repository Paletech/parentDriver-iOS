//
//  AppStateProvidable.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import Foundation

enum AppState {
    case unauthorized
    case selectBus
    case mainFlow
}

protocol AppStateProvidable {
    func provideAppState() -> AppState
}

extension AppStateProvidable {
    func provideAppState() -> AppState {
        let tokenStore: KeycheinStore<Token> = inject()
        let busStore: KeycheinStore<Bus> = inject()
        
        if let _ = try? tokenStore.get(from: KeychainKeys.token.rawValue) {
            if let _ = try? busStore.get(from: KeychainKeys.selectedBus.rawValue) {
                return .mainFlow
            } else {
                return .selectBus
            }
        } else {
            return .unauthorized
        }
    }
}
