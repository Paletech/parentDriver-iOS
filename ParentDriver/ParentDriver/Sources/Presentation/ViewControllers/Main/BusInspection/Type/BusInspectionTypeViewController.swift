import UIKit

protocol BusInspectionTypeViewControllerOutput: ViewControllerOutput,
                                                BusSelectionProvider,
                                                MenuHandler {
    var isNextButtonEnabled: Bool { get }
    
    func selectInspectionType(_ type: BusInspectionType)
    func onNext()
}

class BusInspectionTypeViewController: UIViewController, NavigationHolderController {
    
    private struct Constants {
        static let offset: CGFloat = 32
        static let titleFontSize: CGFloat = 20
        static let buttonHeight: CGFloat = 50
    }
    
    var busSelectionProvider: BusSelectionProvider { output }
    var menuHandler: MenuHandler { output }
    

    var output: BusInspectionTypeViewControllerOutput!
    
    private let chooseInspectionLabel = UILabel()
    private let preButton = SelectableButton()
    private let postButton = SelectableButton()
    private let nextButton = StateButtton(type: .system)
        
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configureUI()
        setupTitles()
    }

    // MARK: - Private

    private func configureUI() {
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        [chooseInspectionLabel, preButton, postButton, nextButton].forEach { view.addSubview($0) }
        
        configureTitleLabel()
        configureButtons()
    }
    
    private func configureTitleLabel() {
        chooseInspectionLabel.font = .systemFont(ofSize: Constants.titleFontSize,
                                                 weight: .semibold)
        chooseInspectionLabel.textColor = .black
        chooseInspectionLabel.numberOfLines = 0
    }
    
    private func configureButtons() {
        [preButton, postButton, nextButton].forEach {
            $0.layer.cornerRadius = Constants.buttonHeight / 2
        }
        
        nextButton.setEnabled(false, animated: false)
        nextButton.setTitleColor(.white, for: .normal)
        
        preButton.addAction { [weak self] in
            self?.preButton.isSelected = true
            self?.postButton.isSelected = false
            self?.output.selectInspectionType(.pre)
        }
        
        postButton.addAction { [weak self] in
            self?.preButton.isSelected = false
            self?.postButton.isSelected = true
            self?.output.selectInspectionType(.post)
        }
        
        nextButton.addAction { [weak self] in
            self?.output.onNext()
        }
    }
    
    private func configureConstraints() {
        chooseInspectionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(Constants.offset)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offset)
        }
        
        preButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(Constants.offset)
            make.top.equalTo(chooseInspectionLabel.snp.bottom).offset(Constants.offset)
        }
        
        postButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(Constants.offset)
            make.top.equalTo(preButton.snp.bottom).offset(Constants.offset)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(Constants.offset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.offset)
        }
        
        [preButton, postButton, nextButton].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(Constants.buttonHeight)
            }
        }
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        chooseInspectionLabel.text = Localizable.label_inspection_type()
        preButton.setTitle(Localizable.enum_inspection_type_pre(), for: .normal)
        postButton.setTitle(Localizable.enum_inspection_type_post(), for: .normal)
        nextButton.setTitle(Localizable.button_next(), for: .normal)
    }
}

// MARK: - Private BusInspectionTypeViewModelOutput
extension BusInspectionTypeViewController: BusInspectionTypeViewModelOutput {
    func dataDidUpdate() {
        nextButton.setEnabled(output.isNextButtonEnabled)
    }
    
    func startActivity() {
        nextButton.isUserInteractionEnabled = false
        nextButton.setTitle(nil, for: .normal)
        nextButton.showActivityIndicator()
    }
    
    func stopActivity() {
        nextButton.isUserInteractionEnabled = true
        nextButton.setTitle(Localizable.button_next(), for: .normal)
        nextButton.removeActivityIndicator()
    }
}
