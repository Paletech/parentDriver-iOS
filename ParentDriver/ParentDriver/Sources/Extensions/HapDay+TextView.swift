import UIKit

extension UITextView {

    func calculateViewHeightWithCurrentWidth() -> CGFloat {
        let textWidth = self.frame.width -
            self.textContainerInset.left -
            self.textContainerInset.right -
            self.textContainer.lineFragmentPadding * 2.0 -
            self.contentInset.left -
            self.contentInset.right

        let maxSize = CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)
        var calculatedSize = self.attributedText.boundingRect(with: maxSize,
                                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                      context: nil).size
        if text.isEmpty {
            return font!.lineHeight + self.textContainerInset.top + self.textContainerInset.bottom
        } else {
            calculatedSize.height += self.textContainerInset.top
            calculatedSize.height += self.textContainerInset.bottom
            return ceil(calculatedSize.height)
        }

    }

    func calculateHeight(for numberOfLines: Int) -> CGFloat {
        return CGFloat(numberOfLines) * font!.lineHeight
    }

}
