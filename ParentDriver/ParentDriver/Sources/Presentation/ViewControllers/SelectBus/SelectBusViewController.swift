import UIKit

protocol SelectBusViewControllerOutput: ViewControllerOutput {
    func numberOfItems() -> Int
    func titleForItem(at indexPath: IndexPath) -> String
    func selectItem(at indexPath: IndexPath)
    func searchForQuery(_ query: String)
}

class SelectBusViewController: UIViewController {
    
    private struct Constants {
        static let horizontalOffset: CGFloat = 16
    }
    
    var output: SelectBusViewControllerOutput!
    
    private let emptySearchLabel = UILabel()
    private let tableView = UITableView()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.start()
        
        configureUI()
        setupSearchController()
        
        configureConstraints()
        
        setupTitles()
    }
    
    // MARK: - Private
    
    private func configureUI() {
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
    
    // MARK: - Localisation
    
    private func setupTitles() {
        title = Localizable.title_select_bus()
        emptySearchLabel.text = Localizable.error_empty_search()
    }
}

// MARK: - Private SelectBusViewModelOutput
extension SelectBusViewController: SelectBusViewModelOutput {
    
    func startActivity() {
        view.showActivityIndicator(style: .medium, tintColor: UIColor.gray)
    }
    
    func stopActivity() {
        view.removeActivityIndicator()
    }
    
    func dataDidUpdate() {
        emptySearchLabel.isHidden = output.numberOfItems() != 0
        tableView.isHidden = output.numberOfItems() == 0
        tableView.reloadData()
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension SelectBusViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = output.titleForItem(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        output.selectItem(at: indexPath)
    }
}

// MARK: - UISearchResultsUpdating
extension SelectBusViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        output.searchForQuery(query)
    }
}
