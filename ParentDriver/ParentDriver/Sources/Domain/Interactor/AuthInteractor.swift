//
//  AuthInteractor.swift
//  ParentDriver
//
//  Created by Pavel Reva on 24.10.2021.
//

import Firebase
import Combine

class AuthInteractor: Interactor, AppStateProvidable {
    
    private struct RemoteConfigKeys {
        static let isSignUpAvailable = "is_sign_up_available"
    }
    
    struct Dependencies {
        let repo: AuthRepository
    }
    
    private let dp: Dependencies
    private let remoteConfig: RemoteConfig
    
    // MARK: - Init/Deinit
    
    init(dp: Dependencies) {
        self.dp = dp
        remoteConfig = RemoteConfig.remoteConfig()
        
        setupRemoteConfig()
    }
    
    // MARK: - RemoteConfig

    func fetchAnActivateConfig(completion: @escaping ((Bool) -> Void)) {
        remoteConfig.fetchAndActivate { status, error in
            switch status {
            case .successFetchedFromRemote, .successUsingPreFetchedData:
                completion(true)
            case .error:
                completion(false)
            @unknown default:
                completion(false)
            }
        }
    }
    
    func isSignUpAvailable() -> Bool {
        remoteConfig.configValue(forKey: RemoteConfigKeys.isSignUpAvailable).boolValue
    }
    
    // MARK: - Networking
    
    func signIn(driverId: String,
                password: String,
                schoolId: String) -> AnyPublisher<Void, Error> {
        dp.repo.signIn(driverId: driverId,
                                 password: password,
                                 schoolId: schoolId)
            .map {
                self.storeAuthRepsponse($0)
            }.eraseToAnyPublisher()
    }
    
    private func storeAuthRepsponse(_ response: AuthResponse) {
        let user = response.user
        
        let token = Token()
        token.accessToken = response.token
        token.dbId = response.user?.dbId
        
        user.flatMap {
            dp.repo.saveSession(token: token, user: $0)
        }
    }

    func removeSession() {
        dp.repo.removeSession()
    }
    
    // MARK: - Private
    
    private func setupRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        
        remoteConfig.configSettings = settings
    }
}
