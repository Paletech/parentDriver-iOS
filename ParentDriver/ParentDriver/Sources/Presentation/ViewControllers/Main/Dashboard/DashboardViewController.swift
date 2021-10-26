import UIKit

protocol DashboardViewControllerOutput: ViewControllerOutput,
                                        BusSelectionProvider,
                                        MenuHandler  {
    func openMenuItem(_ item: MenuItem)
}

class DashboardViewController: UIViewController, NavigationHolderController {
    
    private struct Constants {
        static let offset: CGFloat = 16
        static let buttonHeight: CGFloat = 50
        static let titleFontSize: CGFloat = 20
    }
    
    var busSelectionProvider: BusSelectionProvider { output }
    var menuHandler: MenuHandler { output }
    
    var output: DashboardViewControllerOutput!
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        
        configureUI()
        configureConstraints()

        setupTitles()
    }

    // MARK: - Private

    private func configureUI() {
        [titleLabel, stackView].forEach { view.addSubview($0) }
        
        view.backgroundColor = .white
        
        configureTitleLabel()
        configureStackView()
        configureButtons()
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        titleLabel.textColor = .black
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constants.offset
    }
    
    private func configureButtons() {
        let buttons: [UIButton] = [createButton(title: Localizable.title_monitor_boarding(), targetMenuItem: .monitorBoarding),
                                   createButton(title: Localizable.title_bus_inspection(), targetMenuItem: .busInspection),
                                   createButton(title: Localizable.title_ridersheep_changes(), targetMenuItem: .ridersheepChanges)]
        buttons.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func createButton(title: String, targetMenuItem: MenuItem) -> UIButton {
        let stateButton = StateButtton(type: .system)
        
        stateButton.setTitle(title, for: .normal)
        stateButton.addAction(for: .touchUpInside) { [weak self] in
            self?.output.openMenuItem(targetMenuItem)
        }
        
        stateButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
        }
        
        stateButton.setTitleColor(.white, for: .normal)
        stateButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        stateButton.layer.cornerRadius = Constants.buttonHeight / 2
        
        return stateButton
    }
    
    private func configureConstraints() {
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offset * 2)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.offset * 2)
        }
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        titleLabel.text = Localizable.title_dashboard()
    }
}

// MARK: - Private DashboardViewModelOutput
extension DashboardViewController: DashboardViewModelOutput { }
