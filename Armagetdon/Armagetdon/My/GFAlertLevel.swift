import UIKit
import SnapKit

class GFAlertLevel: UIViewController {
    
    let imageView = UIImageView()
    let closeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureImageView()
        configureCloseButton()
    }
    
    func configureImageView() {
        view.addSubview(imageView)
        imageView.image = UIImage(named: "levelInfo.png")  // Ensure the image is added to your project
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(280)
            make.height.equalTo(400)  // Adjust the size as needed
        }
    }
    
    func configureCloseButton() {
        view.addSubview(closeButton)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(24)
            make.trailing.equalTo(imageView).offset(-18)
            make.width.height.equalTo(20)
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
