import Repository
import ObjectMapper
import Foundation
import Combine

struct AuthRepository: Repository, Syncable {

    let remote: RemoteStoreMappable<AuthResponse>
    
    private let userStore: KeycheinStore<User>
    private let tokenStore: KeycheinStore<Token>

    // MARK: - Fabric method
    
    static func `default`() -> AuthRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return AuthRepository(remote: RemoteStoreMappable(session: session, handler: handler),
                              userStore: inject(),
                              tokenStore: inject())
    }

    // MARK: - Network
    
    func signIn(driverId: String,
                       password: String,
                       schoolId: String) -> AnyPublisher<AuthResponse, Error> {
        remote.requestObject(request: AuthRequests.signInRequest(driverId: driverId,
                                                                 password: password,
                                                                 schoolId: schoolId))
    }
    
    // MARK: - Local
    
    func saveSession(token: Token, user: User) {
        try? tokenStore.save(token, at: KeychainKeys.token.rawValue)
        try? userStore.save(user, at: KeychainKeys.user.rawValue)
    }

    func removeSession() {
        try? tokenStore.remove(from: KeychainKeys.token.rawValue)
        try? userStore.remove(from: KeychainKeys.user.rawValue)
    }
}
