import Foundation
import Repository
import KeychainSwift

class DependencyProvider {
    
    static func configure() {
        configureCoreDependencies()
        configureRepositories()
        configureInteractors()
    }
    
    static private func configureCoreDependencies() {
        let store: Store = KeychainSwift()
        registerService(service: store)
        
        let tokenStore: KeycheinStore<Token> = KeycheinStore(store)
        registerService(service: tokenStore)
    
        var loger: Log {
            switch API.Configuration.current {
            case .development: return DEBUGLog()
            case .qa: return DEBUGLog()
            case .production: return RELEASELog()
            }
        }

        let handler: BaseHandler = Handler(loger)
        
        registerService(service: loger)
        registerService(service: handler)
    }

    static private func configureInteractors() {
        let validationInteractor = ValidationInteractor()
        registerService(service: validationInteractor)
    }
    
    static private func configureRepositories() {
        
    }
    
    static private func registerService<T>(service: T, name: String? = nil) {
       ServiceLocator.shared.register(service: service)
   }
    
    static private  func register<T>(service: @escaping () -> T, name: String? = nil) {
        ServiceLocator.shared.register(service: service)
    }
}

func inject<T>() -> T {
    return ServiceLocator.shared.get()
}
