import UIKit

protocol MonitorBoardingViewControllerOutput: ViewControllerOutput,
                                              BusSelectionProvider,
                                              MenuHandler {
    func numberOfImtes() -> Int
    func item(for indexPath: IndexPath) -> MonitorBoardingUIModel
    func onAdd()
}

class MonitorBoardingViewController: UIViewController,
                                     NavigationHolderController {
    
    private struct Constants {
        static let offset: CGFloat = 32
        static let titleFontSize: CGFloat = 20
        static let errorLabelFontSize: CGFloat = 16
    }
    
    var output: MonitorBoardingViewControllerOutput!
    var busSelectionProvider: BusSelectionProvider { output }
    var menuHandler: MenuHandler { output }
    
    
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    private let errorLabel = UILabel()
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupRightBarButtonItem()
        
        output.start()
        configureUI()
        
        configureConstraints()
        
        setupTitles()
    }

    // MARK: - Private

    private func configureUI() {
        view.backgroundColor = .white
        
        configureTitleLabel()
        configureTableView()
        configureErrorLabel()
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsSelection = false
        
        tableView.registerReusable(MonitorBoardingCell.self)
        
        tableView.isHidden = true
    }
    
    private func configureErrorLabel() {
        view.addSubview(errorLabel)
        
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: Constants.errorLabelFontSize, weight: .semibold)
        errorLabel.textAlignment = .center
        
        errorLabel.isHidden = true
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offset)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.offset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(Constants.offset)
        }
    }
    
    private func setupRightBarButtonItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: nil)
        
        barButtonItem.actionClosure = { [weak self] in
            self?.onAddClicked()
        }
        barButtonItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: - Actions
    
    @objc private func onAddClicked() {
        output.onAdd()
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        titleLabel.text = Localizable.title_monitor_boarding()
    }
}

// MARK: - Private MonitorBoardingViewModelOutput
extension MonitorBoardingViewController: MonitorBoardingViewModelOutput {

    func dataDidUpdate() {
        tableView.isHidden = output.numberOfImtes() == 0
        errorLabel.isHidden = output.numberOfImtes() != 0
        tableView.reloadData()
    }
    
    func catchError(_ error: Error) {
        tableView.isHidden = false
        tableView.reloadData()
//        if error is ServerError {
//            errorLabel.isHidden = false
//            tableView.isHidden = true
//            errorLabel.text = error.localizedDescription
//        } else {
//            showAlert(error.localizedDescription)
//        }
    }
    
    func startActivity() {
        view.showActivityIndicator(style: .medium, tintColor: .gray)
    }
    
    func stopActivity() {
        view.removeActivityIndicator()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MonitorBoardingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfImtes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MonitorBoardingCell()
        cell.setup(item: output.item(for: indexPath))
        return cell
    }
}
