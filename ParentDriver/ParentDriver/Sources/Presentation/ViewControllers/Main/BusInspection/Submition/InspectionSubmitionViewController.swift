import UIKit

protocol InspectionSubmitionViewControllerOutput: ViewControllerOutput {
    func changeIsSafeToOperate(value: Bool)
    func changeIsEverythingWasChecked(value: Bool)
    func submit(comment: String?)
}

class InspectionSubmitionViewController: UIViewController {

    private struct Constants {
        static let offset: CGFloat = 16
        static let textViewHight: CGFloat = 100
        static let textViewConrnerRadius: CGFloat = 8
        static let textViewBorderWidth: CGFloat = 1
        static let textViewBorderColor: UIColor = .gray
        static let submitButtonHeight: CGFloat = 50
    }
    
    var output: InspectionSubmitionViewControllerOutput!
    
    private let titleLabel = UILabel()
    private let textViewPlaceholder = UILabel()
    private let textView = UITextView()
    private let isVechicleSaveToOperateView = YesNoView()
    private let isEverythingWasCheckedView = YesNoView()
    private let submitButton = StateButtton(type: .system)
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
    }
    
    // MARK: - Private

    private func configureUI() {
        configureViews()
        configureConstraints()
        setupLocalisation()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        [titleLabel,
         textViewPlaceholder,
         textView,
         isVechicleSaveToOperateView,
         isEverythingWasCheckedView,
         submitButton].forEach { view.addSubview($0) }
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        textViewPlaceholder.numberOfLines = 0
        textViewPlaceholder.textColor = .black
        textViewPlaceholder.font = .systemFont(ofSize: 16)
        
        textView.layer.borderColor = Constants.textViewBorderColor.cgColor
        textView.layer.borderWidth = Constants.textViewBorderWidth
        textView.layer.cornerRadius = Constants.textViewConrnerRadius
        
        isVechicleSaveToOperateView.onUpdateSelection = { [weak self] in
            self?.output.changeIsSafeToOperate(value: $0 == .yes ? true : false)
        }
        
        isEverythingWasCheckedView.onUpdateSelection = { [weak self] in
            self?.output.changeIsEverythingWasChecked(value: $0 == .yes ? true : false)
        }
        
        submitButton.layer.cornerRadius = Constants.submitButtonHeight / 2
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        submitButton.setEnabled(false, animated: false)
        submitButton.addAction { [weak self] in
            guard let self = self else { return }
            self.output.submit(comment: self.textView.text)
        }
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offset)
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
        }
        
        textViewPlaceholder.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(2 * Constants.offset)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.top.equalTo(textViewPlaceholder.snp.bottom).offset(Constants.offset / 2)
            make.height.equalTo(Constants.textViewHight)
        }
        
        submitButton.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.offset)
            make.height.equalTo(Constants.submitButtonHeight)
        }
        
        isEverythingWasCheckedView.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(submitButton.snp.top).offset(-Constants.offset)
        }
        
        isVechicleSaveToOperateView.snp.makeConstraints { make in
            make.left.equalTo(Constants.offset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(isEverythingWasCheckedView.snp.top).offset(-Constants.offset)
        }
    }
    
    private func setupLocalisation() {
        title = Localizable.title_bus_inspection()
        titleLabel.text = Localizable.title_finalize_bus_inspection()
        textViewPlaceholder.text = Localizable.placeholder_comments()
        isVechicleSaveToOperateView.title = Localizable.labe_is_vechile_safe()
        isEverythingWasCheckedView.title = Localizable.label_have_all_seats_been_checked()
        submitButton.setTitle(Localizable.button_submit(), for: .normal)
    }
}

// MARK: - Private InspectionSubmitionViewModelOutput
extension InspectionSubmitionViewController: InspectionSubmitionViewModelOutput {
    func startActivity() {
        submitButton.isUserInteractionEnabled = false
        submitButton.setTitle(nil, for: .normal)
        submitButton.showActivityIndicator()
    }
    
    func stopActivity() {
        submitButton.isUserInteractionEnabled = true
        submitButton.setTitle(Localizable.button_submit(), for: .normal)
        submitButton.removeActivityIndicator()
    }
    
    func updateSubmitEnabledState(value: Bool) {
        submitButton.setEnabled(value)
    }
}
