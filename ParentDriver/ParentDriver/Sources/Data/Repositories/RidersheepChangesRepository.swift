import Repository
import ObjectMapper
import Foundation
import Combine

enum RidersheepChangesError: Error {
    case noBusSelected
}

struct RidersheepChangesRepository: Repository, Syncable {

    private struct Keys {
        static let ridersheepChangeKey = "change"
    }

    let remote: RemoteStoreMappable<RidersheepChanges>
    let busLocal: KeycheinStore<Bus>

    // MARK: - Fabric method

    static func `default`() -> RidersheepChangesRepository {
        let session: MainSessionManager = inject()
        let handler: Handler = inject()
        return RidersheepChangesRepository(remote: RemoteStoreMappable(session: session, handler: handler), busLocal: inject())
    }

    // MARK: - Network

    func getAll() -> AnyPublisher<[RidersheepChanges], Error> {
        guard let bus = try? busLocal.get(from: KeychainKeys.selectedBus.rawValue) else {
            return Fail(error: RidersheepChangesError.noBusSelected).eraseToAnyPublisher()
        }
        
        return remote.requestArray(request: RidersheepChangesRequests.getAll(busId: bus.trackerId),
                            keyPath: Keys.ridersheepChangeKey)
    }
}
