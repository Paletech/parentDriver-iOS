import UIKit

protocol MenuViewControllerOutput: ViewControllerOutput {
    func numberOfItems() -> Int
    func titleForItemAt(at indexPath: IndexPath) -> String?
    func selectItem(at indexPath: IndexPath)
}

class MenuViewController: UIViewController {

    private struct Constants {
        static let imageSize: CGFloat = 100
        static let offset: CGFloat = 24
    }
    
    var output: MenuViewControllerOutput!
    
    private let titleImageView = UIImageView()
    private let tableView = UITableView()
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
    }
    
    // MARK: - Private

    private func configureUI() {
        view.backgroundColor = .white
        [titleImageView, tableView].forEach { view.addSubview($0) }
        
        configureImageView()
        configureTalbeView()
    }
    
    private func configureImageView() {
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = R.image.ic_logo()
    }
    
    private func configureTalbeView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configureConstraints() {
        titleImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.offset)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.imageSize)
        }
        
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(titleImageView.snp.bottom).offset(Constants.offset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - Private MenuViewModelOutput
extension MenuViewController: MenuViewModelOutput { }

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = output.titleForItemAt(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.selectItem(at: indexPath)
    }
}
