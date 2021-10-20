import Foundation
import Repository

class DependencyProvider {
    
    static func configure() {
        configureCoreDependencies()
        configureRepositories()
        configureInteractors()
    }
    
    static private func configureCoreDependencies() {
        let validationInteractor = ValidationInteractor()
        
        registerService(service: validationInteractor)
//        var loger: Log {
//            switch API.current {
//            case .development: return DEBUGLog()
//            case .acceptance: return DEBUGLog()
//            case .production: return RELEASELog()
//            }
//        }
//
//        let handler: BaseHandler = Handler(loger)
    }

    static private func configureInteractors() {
//        register {
//            UserInteractor(dependencies: UserInteractor.Dependencies(repository: inject(), user: inject()))
//        }
    }
    
    static private func configureRepositories() {
//        register {
//            AuthRepository(auth: inject())
//        }
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
