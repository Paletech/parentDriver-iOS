//
//  MonitorBoardingInteractor.swift
//  ParentDriver
//
//  Created by Pavel Reva on 26.10.2021.
//

import Combine

enum MonitorBoardingErorr: Error {
    case noBusSelected
}

class MonitorBoardingInteractor: Interactor {
    
    struct Dependencies {
        let repo: MonitorBoardingRepository
        let busStore: KeycheinStore<Bus>
    }
    
    let dp: Dependencies
    
    // MARK: - Init/Deinit
    
    init(dp: Dependencies) {
        self.dp = dp
    }
    
    // MARK: - Network
    
    func getAll() -> AnyPublisher<[MonitorBoarding], Error> {
        let interval: String = "1"
        
        if let selectedBus: Bus = try? dp.busStore.get(from: KeychainKeys.selectedBus.rawValue) {
            return dp.repo.getAll(trackerId: selectedBus.trackerId, interval: interval)
        } else {
            return Future({ promise in promise(.failure(MonitorBoardingErorr.noBusSelected)) }).eraseToAnyPublisher()
        }
    }
}
