import UIKit

class WindowCoordinator: Coordinator<UIWindow> {
    func setRoot(viewControler: UIViewController, options: UIView.AnimationOptions = .transitionCrossDissolve) {
        container.rootViewController = viewControler
        UIView.transition(with: container,
                          duration: 0.5,
                          options: options,
                          animations: nil,
                          completion: nil)
    }
}
