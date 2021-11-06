import Foundation
import Repository

struct RidersheepChangesRequests {
    static func getAll() -> RequestProvider {
        return Request(method: .post, path: API.RidersheepChanges.get)
    }
}
