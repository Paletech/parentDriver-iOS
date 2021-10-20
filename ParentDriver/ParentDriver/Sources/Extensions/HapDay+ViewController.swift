import UIKit

extension UIViewController {

    static func topViewController(controller: UIViewController? = UIApplication.shared.windows.last?.rootViewController) -> UIViewController? {
        if let navigationController: UINavigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        if let tabController: UITabBarController = controller as? UITabBarController {
            if let selected: UIViewController = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }

        if let presented: UIViewController = controller?.presentedViewController {
            return topViewController(controller: presented)
        }

        return controller
    }

    func alignLeft(_ view: Any) {
        let constraint = NSLayoutConstraint(item: view,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .left,
                                                multiplier: 1.0,
                                                constant: 0.0)
        self.view.addConstraint(constraint)
    }

    func alignRight(_ view: Any) {
        let constraint = NSLayoutConstraint(item: view,
                                                attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .right,
                                                multiplier: 1.0,
                                                constant: 0.0)
        self.view.addConstraint(constraint)
    }

    var topVC: UIViewController? {
        if let presentedVC = presentedViewController {
            return presentedVC.topVC
        } else {
            return self
        }
    }

    func alignTop(_ view: Any) {
        let constraint = NSLayoutConstraint(item: view,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .top,
                                                multiplier: 1.0,
                                                constant: 0.0)
        self.view.addConstraint(constraint)
    }

    func alignBottom(_ view: Any) {
        let constraint = NSLayoutConstraint(item: view,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: 0.0)
        self.view.addConstraint(constraint)
    }

    func addChild(_ vc: UIViewController, to view: UIView) {
        vc.willMove(toParent: self)
        view.addSubview(vc.view)

        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        vc.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        addChild(vc)
        vc.didMove(toParent: self)
    }
}
