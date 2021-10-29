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
        
        let userStore: KeycheinStore<User> = KeycheinStore(store)
        registerService(service: userStore)
        
        let busStore: KeycheinStore<Bus> = KeycheinStore(store)
        registerService(service: busStore)

        let loger: Log = DEBUGLog()
        let handler: Handler = Handler(loger)
        let sessionManager = MainSessionManager.default()
        
        registerService(service: loger)
        registerService(service: handler)
        registerService(service: sessionManager)
    }
    
    static private func configureRepositories() {
        let authRepository = AuthRepository.default()
        registerService(service: authRepository)
        
        let busRepository = BusRepository.default()
        registerService(service: busRepository)
        
        let monitorBoardingRepository = MonitorBoardingRepository.default()
        registerService(service: monitorBoardingRepository)
    }

    static private func configureInteractors() {
        let validationInteractor = ValidationInteractor()
        registerService(service: validationInteractor)
        
        let authInteractor = AuthInteractor(dp: AuthInteractor.Dependencies(repo: inject()))
        registerService(service: authInteractor)
        
        let busInteractor = BusInteractor(dp: BusInteractor.Dependencies(repo: inject()))
        registerService(service: busInteractor)
        
        let monitorBoardingInteractor = MonitorBoardingInteractor(dp: MonitorBoardingInteractor.Dependencies(repo: inject(),
                                                                                                             busStore: inject()))
        registerService(service: monitorBoardingInteractor)
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
