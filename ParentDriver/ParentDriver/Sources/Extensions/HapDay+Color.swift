import UIKit

public extension UIColor {

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) {
        let normalizedRed = CGFloat(red) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255
        self.init(red: normalizedRed, green: normalizedGreen, blue: normalizedBlue, alpha: alpha)
    }
}
