import UIKit

extension UIDevice {

    static var isIphoneSE: Bool {
        return UIScreen.main.bounds.height == 568
    }

    static var isIphone6: Bool {
         return UIScreen.main.bounds.height == 667
    }

    static var isIphone6Plus: Bool {
        return UIScreen.main.bounds.height == 736
    }

    static var isLessThanX: Bool {
        return isIphoneSE || isIphone6 || isIphone6Plus
    }
}
