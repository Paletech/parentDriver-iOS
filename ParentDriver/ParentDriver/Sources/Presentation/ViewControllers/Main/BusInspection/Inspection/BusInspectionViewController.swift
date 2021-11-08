import UIKit

protocol BusInspectionViewControllerOutput: ViewControllerOutput {
    func onNext()
}

class BusInspectionViewController: UIViewController,
                                   ScrollableContrainer,
                                   StackContainable {
    
    private struct Constants {
        static let horizontalOffset: CGFloat = 16
        static let buttonHeight: CGFloat = 50
    }
    
    var scrollView = UIScrollView()
    var scrollableContainer = UIView()
    var stackView = UIStackView()
    
    private let nextButton = StateButtton(type: .system)
    
    var output: BusInspectionViewControllerOutput!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = stackView.frame.size
    }

    // MARK: - Private

    private func configureUI() {
        configureViews()
        configureConstraints()
        
        setupTitles()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        configureScrollView()
        configureStackView()
        configureNextButton()
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = Constants.buttonHeight / 2
        nextButton.addAction { [weak self] in
            self?.output.onNext()
        }
    }
    
    private func configureConstraints() {
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).offset(-Constants.horizontalOffset)
            make.centerX.equalToSuperview()
            make.left.equalTo(Constants.horizontalOffset)
            make.height.equalTo(Constants.buttonHeight)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(nextButton.snp.top).offset(-Constants.horizontalOffset * 2)
            make.left.right.equalTo(0)
        }
        
        configureScrollConstraints()
        configureScrollStackViewContstraints(horizontalOffset: Constants.horizontalOffset)
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        title = Localizable.title_bus_inspection()
        nextButton.setTitle(Localizable.button_next(), for: .normal)
    }
}

// MARK: - Private BusInspectionViewModelOutput
extension BusInspectionViewController: BusInspectionViewModelOutput {
    func dataDidUpdate(dataSource: DataSourceComposable) {
        let views = dataSource.dataSources.map { $0.interfase() }
        views.forEach { stackView.addArrangedSubview($0) }
    }
}
