import UIKit

extension String {

    var url: URL? {
        return URL(string: self)
    }

    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }

    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil || self.isEmpty
    }

    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintSize: CGSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox: CGRect = self.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin,
                                                    attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    var notEmpty: String {
        return isEmpty ? "unknown" : self
    }

    var fullRange: NSRange { NSRange(location: 0, length: self.count) }

    func attributed(withSpacing lineSpacing: CGFloat,
                    font: UIFont,
                    alignment: NSTextAlignment = .center) -> NSAttributedString {

        let result = NSMutableAttributedString(string: self)

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = lineSpacing
        style.alignment = alignment

        result.addAttribute(.paragraphStyle, value: style, range: fullRange)
        result.addAttribute(.font, value: font, range: fullRange)

        return result
    }
}

extension RangeExpression where Bound == String.Index {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}

extension NSMutableAttributedString {
    public func setAsLink(textToFind: String, linkURL: String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        
        return false
    }
}
