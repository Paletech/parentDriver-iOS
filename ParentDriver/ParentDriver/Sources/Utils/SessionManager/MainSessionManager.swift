import Alamofire
import KeychainSwift
import Repository
import Foundation

struct Keys {
    static let authorization = "Authorization"
    static let accept = "Accept"
    static let contentType = "Content-Type"
}

struct DefaultHTTPHeaders {

    static var main: HTTPHeaders {
        var header = self.default
        
        let accept = HTTPHeader(name: Keys.accept, value: "application/json")
        let contentType = HTTPHeader(name: Keys.contentType, value: "application/json")
        
        header.add(accept)
        header.add(contentType)
        
        return header
    }

    static let `default` = HTTPHeaders.default

    static func adapt(_ urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest

        main.forEach {
            if let headers = urlRequest.allHTTPHeaderFields, headers[$0.name] == nil {
                urlRequest.setValue($0.value, forHTTPHeaderField: $0.name)
            }
        }
        return urlRequest
    }
}

class MainSessionManager: Session {
    
    static func `default`(intercector: RequestInterceptor = Intercector(adapter: TokenAdapter())) -> MainSessionManager {
        let session = MainSessionManager(configuration: URLSessionConfiguration.default, interceptor: intercector)
        return session
    }
}

class Intercector: RequestInterceptor {
    private var adapter: RequestAdapter
    
    init(adapter: RequestAdapter) {
        self.adapter = adapter
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        adapter.adapt(urlRequest, for: session, completion: completion)
    }
}

class TokenAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        if urlRequest.allHTTPHeaderFields?["auth-token"] == nil {
            let tokenStore: KeycheinStore<Token> = inject()
            if let token = try? tokenStore.get(from: KeychainKeys.token.rawValue).accessToken {
                urlRequest.setValue(token, forHTTPHeaderField: "auth-token")
            }
        }
        
        completion(.success(urlRequest))
    }
}
