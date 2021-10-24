import Repository
import Alamofire
import Foundation

enum ServerError: Error, LocalizedError {
    case error(String)
    
    var errorDescription: String? {
        switch self {
        case .error(let value):
            return value
        }
    }
}

enum RequestResultValue: String {
    case error
    case success
}

class Handler: BaseHandler {
    
    private struct Constants {
        static let resultKey = "result"
        static let messageKey = "message"
    }
    
    override func responseSuccess<T>(_ response: AFDataResponse<T>, item: T) -> Result<T, Error> {
        if let networkError = errorFromResponse(response) {
            return .failure(networkError)
        } else {
            return .success(item)
        }
    }
    
    override func responseError<T>(_ response: AFDataResponse<T>, error: Error) -> Result<T, Error> {
        if let networkError = errorFromResponse(response) {
            return .failure(networkError)
        } else {
            return .failure(error)
        }
    }
    
    private func errorFromResponse<T>(_ response: AFDataResponse<T>) -> Error? {
        if  let data = response.data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if json[Constants.resultKey] as? String == RequestResultValue.error.rawValue {
                let message: String = json[Constants.messageKey] as? String ?? ""
                return ServerError.error(message)
            }
        }
        
        return nil
    }
}
