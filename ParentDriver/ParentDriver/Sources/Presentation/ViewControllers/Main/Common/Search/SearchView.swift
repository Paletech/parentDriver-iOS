//
//  SearchView.swift
//  ParentDriver
//
//  Created by Pavel Reva on 28.10.2021.
//

import Foundation
import UIKit

protocol SearchView { }

protocol SearchViewOutout {
    func numberOfItems() -> Int
    func titleForItem(at indexPath: IndexPath) -> String
    func selectItem(at indexPath: IndexPath)
    func searchForQuery(_ query: String)
}

extension SearchView where Self: UIViewController {
    
}
