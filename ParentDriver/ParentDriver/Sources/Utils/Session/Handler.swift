import Repository
import Alamofire
import Foundation

class Handler: BaseHandler {
    
    override func responseError<T>(_ response: DataResponse<T, AFError>, error: Error) -> Swift.Result<T, Error> {
        let domain = response.request?.url?.host ?? NSURLErrorDomain

        switch response.response?.statusCode {
        case .none:
            return .failure(generateGeneralError(domain))
        case .some(let statusCode):
            return .failure(generateGeneralError(domain, statusCode))
        }
    }

    private func generateGeneralError(_ domain: String, _ code: Int = 500) -> Error {
        let userInfo: [String: Any] = [
            NSLocalizedDescriptionKey: "",
            NSLocalizedFailureReasonErrorKey: ""
        ]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}
