import ObjectMapper
import Foundation

class RidersheepChanges: Mappable {

    var student: String = ""
    var address: String = ""
    var campus: String = ""

    // MARK: - Mappable

    required init?(map: Map) { }

    func mapping(map: Map) {
        student <- map["student"]
        address <- map["address"]
        campus <- map["campus"]
    }
}
