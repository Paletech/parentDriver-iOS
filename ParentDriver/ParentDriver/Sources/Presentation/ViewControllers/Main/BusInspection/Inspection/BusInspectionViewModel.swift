import Foundation
import UIKit

protocol BusInspectionViewModelOutput: ViewModelOutput {
    func dataDidUpdate(dataSource: DataSourceComposable)
}

class BusInspectionViewModel {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: BusInspectionViewModelOutput!
    
    var dataSource: DataSourceComposable!
    
    private var failedIds: [String] {
        dataSource.dataSources
            .compactMap { $0 as? CheckBoxDataSource }
            .filter { $0.isSelected }
            .map { $0.item.id }
    }

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - BusInspectionViewControllerOutput
extension BusInspectionViewModel: BusInspectionViewControllerOutput {
    
    func start() {
        let title = TitleTextDataSource(field: TitleTextConfig(text: moduleInput.page.title,
                                                               font: .systemFont(ofSize: 20, weight: .semibold),
                                                               textColor: .black))
        var dataSources: [ScrollableStackDataSource] = [title]
        let checkboxes = moduleInput.page.items
                                                .map { Checkbox(id: $0.id, title: $0.name) }
                                                .map { CheckBoxDataSource(field: $0) }
        dataSources.append(contentsOf: checkboxes)
        
        self.dataSource = DataSourceComposable(dataSources: dataSources)
        
        output.dataDidUpdate(dataSource: dataSource)
    }
    
    func onNext() {
        moduleOutput?.action(.next(failedIds))
    }
}
