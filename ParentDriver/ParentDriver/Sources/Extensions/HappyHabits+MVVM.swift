import UIKit

enum LifeCycle {
    case didLoad, didAppear, willAppear, didDisappear, willDisappear, didDeinit
}

protocol ViewControllerOutput: AnyObject {
    
    func change(lifeCycle: LifeCycle)

    func start()
    func updateData()
}

protocol ViewModelOutput: AnyObject {

    func dataDidUpdate()

    func startActivity()
    func stopActivity()
    
    func catchError(_ error: Error)
    func showMessage(_ message: String?)
}

extension ViewControllerOutput {

    func change(lifeCycle: LifeCycle) {
        
    }
    
    func start() {
        
    }
    
    func updateData() {
        
    }
}

extension ViewModelOutput where Self: UIViewController {

    func dataDidUpdate() {
        
    }
    
    func startActivity() {

    }

    func stopActivity() {

    }

    func showAlert(_ alert: String?) {
        showError(alert, nil)
    }

    func showAlert(_ alert: String?, _ handler: (() -> Void)?) {
        showError(alert, handler)
    }

    func catchError(_ error: Error) {
        showError(error.localizedDescription)
    }
    
    func showMessage(_ message: String?) {
        showError(message)
    }

    fileprivate func showError(_ error: String?, _ handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "",
                                                message: error,
                                                preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            handler?()
        })
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {

    func add(_ child: UIViewController, to container: UIView) {
        addChild(child)

        child.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(child.view)
        let left = child.view.leftAnchor.constraint(equalTo: container.leftAnchor)
        let right = child.view.rightAnchor.constraint(equalTo: container.rightAnchor)
        let top = child.view.topAnchor.constraint(equalTo: container.topAnchor)
        let bottom = child.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        NSLayoutConstraint.activate([left, right, top, bottom])

        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController {
    
    func clearBackItemTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func configureRightBarButton(item: UIBarButtonItem) {
        navigationItem.setRightBarButton(item, animated: false)
    }
}
