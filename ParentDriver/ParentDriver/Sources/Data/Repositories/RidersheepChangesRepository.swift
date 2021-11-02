import Repository
import ObjectMapper
import Foundation
import Combine

struct RidersheepChangesRepository: Repository, Syncable {

    private struct Keys {
        static let ridersheepChangeKey = "change"
    }

    let remote: RemoteStoreMappable<RidersheepChanges>

    // MARK: - Fabric method

    static func `default`() -> RidersheepChangesRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return RidersheepChangesRepository(remote: RemoteStoreMappable(session: session, handler: handler))
    }

    // MARK: - Network

    func getAll() -> AnyPublisher<[RidersheepChanges], Error> {
        remote.requestArray(request: RidersheepChangesRequests.getAll(),
                            keyPath: Keys.ridersheepChangeKey)
    }
}
