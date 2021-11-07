//
//  InspectionInteractor.swift
//  ParentDriver
//
//  Created by Pavel Reva on 07.11.2021.
//

import Combine

enum InspectionError: Error {
    case noBusSelected
}

class InspectionInteractor {
    
    struct Dependencies {
        let repo: InspectionRepository
        let locationInteractor: LocationInteractor
    }
    
    let dp: Dependencies
    
    // MARK: - Init/Deinit
    
    init(dp: Dependencies) {
        self.dp = dp
    }
    
    // MARK: - Logic
    
    func getInspection() -> AnyPublisher<[InspectionPage], Error> {
        dp.repo.getInspection()
            .map { items -> [InspectionPage] in
                
                var dict: [String: [InspectionItemResponse]] = [:]
                
                items.forEach { item in
                    if dict[item.loc] == nil {
                        dict[item.loc] = [item]
                    } else {
                        dict[item.loc] = dict[item.loc].flatMap { array in array + [item] }
                    }
                }
                
                return dict.map { (key: String, value: [InspectionItemResponse]) in
                    return InspectionPage(title: key,
                                          items: value.map { InspectionItem(id: $0.id, name: $0.name) })
                }
            }.eraseToAnyPublisher()
    }
    
    func submitInspection(inspectionType: BusInspectionType,
                          failedItems: [InspectionItem],
                          inspectionStatus: InspectionStatus,
                          comments: String? = nil) -> AnyPublisher<Void, Error> {
        guard let bus = dp.repo.getSelectedBus()
        else { return Fail(error: InspectionError.noBusSelected).eraseToAnyPublisher() }
        
        var inspectionSubmition = InspectionSubmitionModel(trackerImei: bus.imei,
                                                           inspectionType: inspectionType,
                                                           failedItems: failedItems.compactMap { $0.id },
                                                           inspectionStatus: inspectionStatus,
                                                           comments: comments)
    
        return dp.locationInteractor.getLocation()
        .map { coordinates -> AnyPublisher<Any, Error> in
            inspectionSubmition.location = coordinates.coordinate.toString
            return self.dp.repo.submitInspection(inspectionSubmition: inspectionSubmition)
        }
        .switchToLatest()
        .map { _ in
            return Future<Void, Error> { promise in promise(.success(())) }
        }
        .switchToLatest()
        .eraseToAnyPublisher()
    }
}
