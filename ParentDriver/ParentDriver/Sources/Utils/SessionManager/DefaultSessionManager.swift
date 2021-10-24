import Alamofire
import Foundation

class DefaultSessionManager: Session {

    static func `default`() -> DefaultSessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        return DefaultSessionManager(configuration: configuration)
    }
}
