//
//  BusInteractor.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import Combine

class BusInteractor: Interactor {
    
    struct Dependencies {
        let repo: BusRepository
    }
    
    let dp: Dependencies
    
    // MARK: - Init/Deinit
    
    init(dp: Dependencies) {
        self.dp = dp
    }
    
    // MARK: - Network
    
    func getAllBuses() -> AnyPublisher<[Bus], Error> {
        dp.repo.getAllBuses()
    }
    
    // MARK: - Local
    
    func saveBusSelection(_ bus: Bus) {
        dp.repo.saveBusSelection(bus)
    }
    
    func getBusSelection() -> Bus? {
        dp.repo.getBusSelection()
    }

    func removeBusSelection() {
        dp.repo.removeBusSelection()
    }
}
