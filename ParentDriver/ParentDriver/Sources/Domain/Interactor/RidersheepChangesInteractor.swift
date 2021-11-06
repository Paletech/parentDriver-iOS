import Combine

class RidersheepChangesInteractor: Interactor {
    
    struct Dependencies {
        let repo: RidersheepChangesRepository
    }

    let dp: Dependencies

    // MARK: - Init/Deinit

    init(dp: Dependencies) {
        self.dp = dp
    }

    // MARK: - Network

    func getAll() -> AnyPublisher<[RidersheepChanges], Error> {
        return dp.repo.getAll()
    }
}
