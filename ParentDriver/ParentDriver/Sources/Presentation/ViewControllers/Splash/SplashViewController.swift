import UIKit

protocol SplashViewControllerOutput: ViewControllerOutput { }

class SplashViewController: UIViewController {

    private struct Constants {
        static let imageSize: CGFloat = 240
    }
    
    var output: SplashViewControllerOutput!
    
    private let imageView = UIImageView()
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
    }

    // MARK: - Private

    private func configureUI() {
        addImageView()
    }
    
    private func addImageView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(Constants.imageSize)
        }
        
        imageView.image = R.image.ic_logo()!
    }
}

// MARK: - Private SplashViewModelOutput
extension SplashViewController: SplashViewModelOutput { }
