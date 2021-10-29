//
//  SearchView.swift
//  ParentDriver
//
//  Created by Pavel Reva on 28.10.2021.
//

import UIKit

typealias SearchViewType = UITableViewDelegate & UITableViewDataSource & UISearchResultsUpdating

protocol SearchViewModelOutput: ViewModelOutput {
    func dataDidUpdate()
}

private struct Constants {
    static let horizontalOffset: CGFloat = 16
}

protocol SearchView {
    var searchViewOutput: SearchViewOutput! { get }
    
    var emptySearchLabel: UILabel { get }
    var tableView: UITableView { get }
}

protocol SearchViewOutput: ViewControllerOutput {
    func numberOfItems() -> Int
    func titleForItem(at indexPath: IndexPath) -> String
    func selectItem(at indexPath: IndexPath)
    func searchForQuery(_ query: String)
}

class BaseSearchViewController: UIViewController, SearchView, SearchViewType, SearchViewModelOutput {
    
    var searchViewOutput: SearchViewOutput! { nil }
    
    var emptySearchLabel = UILabel()
    var tableView = UITableView()
    
    // MARK: - Init/Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func baseSetup() {
        addObservers()

        searchViewOutput.start()
        
        configureUI()
        setupSearchController()
        
        configureConstraints()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        configureEmptySearchLabel()
        configureTableView()
    }
    
    private func configureEmptySearchLabel() {
        emptySearchLabel.numberOfLines = 0
        emptySearchLabel.font = .systemFont(ofSize: 16)
        emptySearchLabel.textColor = .gray
        emptySearchLabel.textAlignment = .center
        
        emptySearchLabel.isHidden = true
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.isHidden = true
    }
    
    private func configureConstraints() {
        [tableView, emptySearchLabel].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        emptySearchLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Constants.horizontalOffset)
        }
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        
        searchController.searchBar.placeholder = Localizable.placeholder_search_bus()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.searchController = searchController
    }
    
    // MARK: - Keyboard
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewOutput.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchViewOutput.titleForItem(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        searchViewOutput.selectItem(at: indexPath)
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        searchViewOutput.searchForQuery(query)
    }
    
    // MARK: - SearchViewModelOutput
    
    func startActivity() {
        view.showActivityIndicator(style: .medium, tintColor: UIColor.gray)
    }
    
    func stopActivity() {
        view.removeActivityIndicator()
    }
    
    func dataDidUpdate() {
        emptySearchLabel.isHidden = searchViewOutput.numberOfItems() != 0
        tableView.isHidden = searchViewOutput.numberOfItems() == 0
        tableView.reloadData()
    }
}
