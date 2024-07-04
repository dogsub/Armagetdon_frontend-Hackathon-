import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    private lazy var navBar: CustomNavigationBar2 = {
        let nav = CustomNavigationBar2()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()
    
    private lazy var introLabel: UILabel = {
        let lb = UILabel()
        lb.text = "선플 업로드 하기 전 \n안내사항을 꼭 읽어주세요"
        lb.font = UIFont(name: "Pretendard-Bold", size: 20)
        lb.textColor = UIColor(named: "Mblack")
        lb.numberOfLines = 0
        return lb
    }()
    
    private lazy var introImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "intro")
        return img
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Rbtn")
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Rbackground")
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(navBar)
        view.addSubview(introLabel)
        view.addSubview(introImg)
        view.addSubview(floatingButton)
    }
    
    private func setupConstraints() {
        navBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
        }
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(104)
            make.left.right.equalToSuperview().inset(20)
        }
        introImg.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(36)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(311)
            make.height.equalTo(208)
        }
        floatingButton.snp.makeConstraints { make in
            make.width.equalTo(337)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
        }
    }
    
    @objc func floatingButtonTapped() {
        // Handle floating button tap
    }
}
