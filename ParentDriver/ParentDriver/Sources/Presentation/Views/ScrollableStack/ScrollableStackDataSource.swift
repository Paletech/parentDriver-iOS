//
//  ScrollableStackDataSource.swift
//  CathNow
//
//  Created by Pavlo Reva on 19/08/2020.
//  Copyright © 2020 Coloplast. All rights reserved.
//

import UIKit

protocol ScrollableStackDataSource: AnyObject {
    var id: String { get }
    var isVisible: Bool { get set }

    func interfase() -> UIView
    func reload()
    func becomeActive() -> Bool
    
    func onChangeVisibility(isVisible: Bool)
}

protocol ScrollableStackField {
    
}

protocol VisibilityChangableDataSource {
    func onChangeVisibility(isVisible: Bool)
}

class StackDataSource<T: Any, V: UIView>: ScrollableStackDataSource, VisibilityChangableDataSource {
    
    var view: V!
    var item: T
    
    var id: String {
        return String(describing: self.view)
    }
    
    var animationDuration: TimeInterval { 1 }
    var isVisible: Bool = true {
        didSet {
            onChangeVisibility(isVisible: isVisible)
            view.alpha = isVisible ? 1 : 0
        }
    }

    init(field: T, isNibSpecific: Bool = false) {
        self.item = field
        self.view = isNibSpecific ? V.instanceFromNib() : V(frame: .zero)
        self.reload()
    }
    
    func reload() { }
    
    func interfase() -> UIView { view }
    
    func becomeActive() -> Bool { return false }
    
    // MARK: - VisibilityChangabeDataSource
    
    func onChangeVisibility(isVisible: Bool) {
        UIView.animate(withDuration: animationDuration) {
            self.view.isHidden = !isVisible
            self.view.alpha = isVisible ? 1 : 0
        }
    }
}

class DataSourceComposable {
    var dataSources: [ScrollableStackDataSource] = []
    
    var views: [UIView] { dataSources.map { $0.interfase() } }
    
    init(dataSources: [ScrollableStackDataSource]) {
        self.dataSources = dataSources
    }
    
    func remove(dataSource: ScrollableStackDataSource) -> Int? {
        guard let index = dataSources.firstIndex(where: {$0.id == dataSource.id}) else { return nil }
        dataSources.remove(at: index)
        return index
    }
    
    func insert(dataSource: ScrollableStackDataSource, afterDataSource: ScrollableStackDataSource) -> Int? {
        
        guard let index = dataSources.firstIndex(where: {$0.id == afterDataSource.id}) else { return nil }
        let newIndex = index + 1
        dataSources.insert(dataSource, at: newIndex)
        return newIndex
    }
}
