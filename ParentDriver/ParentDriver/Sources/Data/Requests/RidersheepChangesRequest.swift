import Foundation
import Repository

struct RidersheepChangesRequests {
    static func getAll(busId: String) -> RequestProvider {
        let query: [String: String] = ["bus_id": busId]
        return Request(method: .post, path: API.RidersheepChanges.get, query: query)
    }
}
