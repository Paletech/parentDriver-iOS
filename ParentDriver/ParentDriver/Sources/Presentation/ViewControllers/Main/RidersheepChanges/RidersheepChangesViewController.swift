import UIKit

protocol RidersheepChangesViewControllerOutput: ViewControllerOutput,
                                                BusSelectionProvider,
                                                MenuHandler {
    func numberOfItems() -> Int
    func item(for indexPath: IndexPath) -> RidersheepChangesUIModel
}

class RidersheepChangesViewController: UIViewController, NavigationHolderController {
    var busSelectionProvider: BusSelectionProvider { output }
    var menuHandler: MenuHandler { output }

    private struct Constants {
        static let offset: CGFloat = 16
        static let titleFontSize: CGFloat = 20
        static let errorLabelFontSize: CGFloat = 16
    }

    var output: RidersheepChangesViewControllerOutput!

    private let tableView = UITableView()
    private let errorLabel = UILabel()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()

        output.start()
        configureUI()
        configureConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateData()
    }

    // MARK: - Private

    private func configureUI() {
        view.backgroundColor = .white

        configureTitleLabel()
        configureTableView()
        configureErrorLabel()
    }

    private func configureTitleLabel() {
        title = Localizable.title_ridersheep_changes()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsSelection = false

        tableView.registerReusable(RidersheepChangesCell.self)
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
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(Constants.offset)
        }
    }
}

// MARK: - Private RidersheepChangesViewModelOutput
extension RidersheepChangesViewController: RidersheepChangesViewModelOutput {

    func dataDidUpdate() {

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RidersheepChangesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(output.numberOfItems())
        return output.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RidersheepChangesCell()
        cell.setup(item: output.item(for: indexPath))
        return cell
    }
}
