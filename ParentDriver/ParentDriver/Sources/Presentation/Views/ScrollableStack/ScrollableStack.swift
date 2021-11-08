import UIKit

@IBDesignable
class ScrollableStack: UIView {
    
    @IBInspectable var spacing: CGFloat = 0
    
    var animationDuration: TimeInterval = 1
    
    var isScrollEnabled: Bool = true {
        didSet {
            scrollView.isScrollEnabled = isScrollEnabled
        }
    }
    
    fileprivate var didSetupConstraints = false

    lazy var stackView: UIStackView = {
        let instance = UIStackView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = .vertical
        instance.spacing = self.spacing
        instance.distribution = .fill
        return instance
    }()
    
    private lazy var scrollView: UIScrollView = {
        let instance = UIScrollView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.layoutMargins = .zero
        instance.showsVerticalScrollIndicator = false
        return instance
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI

    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true

        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func scrollToItem(index: Int) {
        if stackView.arrangedSubviews.count > 0 {
            let view = stackView.arrangedSubviews[index]
            
            UIView.animate(withDuration: animationDuration, animations: {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: view.frame.origin.y), animated: true)
            })
        }
    }
    
    func scrollToBottom() {
        if stackView.arrangedSubviews.count > 0 {
            UIView.animate(withDuration: animationDuration, animations: {
                self.scrollView.scrollToBottom(true)
            })
        }
    }
    
    func scrollToTop() {
        if stackView.arrangedSubviews.count > 0 {
            UIView.animate(withDuration: animationDuration, animations: {
                self.scrollView.setContentOffset(.zero, animated: true)
            })
        }
    }
}

extension UIScrollView {
    func scrollToBottom(_ animated: Bool) {
        if contentSize.height < bounds.size.height { return }

        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
