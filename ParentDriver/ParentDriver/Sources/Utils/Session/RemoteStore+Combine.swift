import Repository
import Combine
import Foundation

public extension RemoteStore {
    
    func requestString(request: RequestProvider) -> AnyPublisher<String, Error> {
        Future { promise in
            send(request: request, responseString: { (response: Swift.Result<String, Error>) -> Void  in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
    
    func requestData(request: RequestProvider) -> AnyPublisher<Data, Error> {
        Future { promise in
            send(request: request, responseData: { (response: Swift.Result<Data, Error>) -> Void  in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
    
    func requestJSON(request: RequestProvider) -> AnyPublisher<Any, Error> {
        Future { promise in
            send(request: request, responseJSON: { (response: Swift.Result<Any, Error>) -> Void  in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
    
    func requestItem<Item>(request: RequestProvider, keyPath: String? = nil) -> AnyPublisher<Item, Error> {
        Future { promise in
            send(request: request, keyPath: keyPath) { (response: Swift.Result<Item, Error>) -> Void in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func requestItems<Item>(request: RequestProvider, keyPath: String? = nil) -> AnyPublisher<[Item], Error> {
        Future { promise in
            send(request: request, keyPath: keyPath) { (response: Swift.Result<[Item], Error>) -> Void in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

public extension RemoteStoreObjects {
    
    func requestArray(request: RequestProvider, keyPath: String? = nil) -> AnyPublisher<[Item], Error> {
        Future { promise in
            send(request: request, keyPath: keyPath, responseArray: { (response: Swift.Result<[Item], Error>) -> Void  in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
    
    func requestObject(request: RequestProvider, keyPath: String? = nil) -> AnyPublisher<Item, Error> {
        Future { promise in
            send(request: request, keyPath: keyPath, responseObject: { (response: Swift.Result<Item, Error>) -> Void  in
                switch response {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            })
        }.eraseToAnyPublisher()
    }
}
