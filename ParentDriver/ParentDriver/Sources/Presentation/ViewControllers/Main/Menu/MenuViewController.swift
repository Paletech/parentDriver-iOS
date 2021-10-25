import UIKit

protocol MenuViewControllerOutput: ViewControllerOutput {
    func numberOfItems() -> Int
    func titleForItemAt(at indexPath: IndexPath) -> String?
    func selectItem(at indexPath: IndexPath)
}

class MenuViewController: UIViewController {

    var output: MenuViewControllerOutput!
    
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
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
