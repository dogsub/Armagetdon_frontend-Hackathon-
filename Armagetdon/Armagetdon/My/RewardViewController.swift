import UIKit
import SnapKit

class RewardViewController: UIViewController {
    
    let rewardbackButton = UIButton()
    let titleLabel = UILabel()
    let rewardImageView = UIImageView()
    let points1Label = UILabel()
    let points2Label = UILabel()
    let optionView = UIView()
    let firstOptionIcon = UIImageView()
    let firstOptionLabel = UILabel()
    let firstOptionButton = UIButton()
    let secondOptionIcon = UIImageView()
    let secondOptionLabel = UILabel()
    let secondOptionButton = UIButton()
    
    var rewardPoints: Int = 0 {
        didSet {
            updatePointsLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.hidesBackButton = true

        // Back Button
        rewardbackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        rewardbackButton.tintColor = .black
        rewardbackButton.addTarget(self, action: #selector(rewardBackButtonTapped), for: .touchUpInside)
        view.addSubview(rewardbackButton)
        rewardbackButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(10)
            make.width.height.equalTo(30)
        }
        
        // Title Label
        titleLabel.text = "리워드 조회"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardbackButton.snp.bottom).offset(25)
            make.leading.equalTo(view).offset(22)
        }
        
        // Reward Image View
        rewardImageView.image = UIImage(named: "rewardExchange")
        view.addSubview(rewardImageView)
        rewardImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.width.height.equalTo(150)
        }
        
        // Points1 Label
        points1Label.font = .systemFont(ofSize: 24, weight: .bold)
        points1Label.textColor = UIColor(hex: "6A48E7", alpha: 1.0)
        points1Label.numberOfLines = 2
        points1Label.textAlignment = .center
        view.addSubview(points1Label)
        points1Label.snp.makeConstraints { make in
            make.top.equalTo(rewardImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        // Points2 Label
        points2Label.text = "모았어요!"
        points2Label.font = UIFont.systemFont(ofSize: 15)
        points2Label.numberOfLines = 2
        points2Label.textAlignment = .center
        view.addSubview(points2Label)
        points2Label.snp.makeConstraints { make in
            make.top.equalTo(points1Label.snp.bottom).offset(15)
            make.centerX.equalTo(view)
        }
        
        // Option View
        optionView.layer.cornerRadius = 10
        optionView.layer.shadowColor = UIColor.black.cgColor
        optionView.layer.shadowOpacity = 0.1
        optionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        optionView.layer.shadowRadius = 4
        optionView.backgroundColor = .white
        view.addSubview(optionView)
        optionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(100)
        }
        
        // First Option Icon
        firstOptionIcon.image = UIImage(named: "rewardMoney1")
        optionView.addSubview(firstOptionIcon)
        firstOptionIcon.snp.makeConstraints { make in
            make.top.equalTo(optionView).offset(15)
            make.leading.equalTo(optionView).offset(15)
            make.width.height.equalTo(24)
        }
        
        // First Option Label
        firstOptionLabel.text = "내가 원하는 곳에 기부하기"
        firstOptionLabel.font = UIFont.systemFont(ofSize: 14)
        optionView.addSubview(firstOptionLabel)
        firstOptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstOptionIcon)
            make.leading.equalTo(firstOptionIcon.snp.trailing).offset(10)
        }
        
        // First Option Button
        firstOptionButton.setTitle("기부처 선택", for: .normal)
        firstOptionButton.setTitleColor(.black, for: .normal)
        firstOptionButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        firstOptionButton.backgroundColor = .systemGray6
        firstOptionButton.layer.cornerRadius = 7
        firstOptionButton.addTarget(self, action: #selector(firstOptionButtonTapped), for: .touchUpInside)
        optionView.addSubview(firstOptionButton)
        firstOptionButton.snp.makeConstraints { make in
            make.centerY.equalTo(firstOptionIcon)
            make.trailing.equalTo(optionView).offset(-15)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        // Second Option Icon
        secondOptionIcon.image = UIImage(named: "rewardMoney2")
        optionView.addSubview(secondOptionIcon)
        secondOptionIcon.snp.makeConstraints { make in
            make.top.equalTo(firstOptionIcon.snp.bottom).offset(20)
            make.leading.equalTo(optionView).offset(15)
            make.width.height.equalTo(24)
        }
        
        // Second Option Label
        secondOptionLabel.text = "나의 계좌에 현금으로 전환하기"
        secondOptionLabel.font = UIFont.systemFont(ofSize: 14)
        optionView.addSubview(secondOptionLabel)
        secondOptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondOptionIcon)
            make.leading.equalTo(secondOptionIcon.snp.trailing).offset(10)
        }
        
        // Second Option Button
        secondOptionButton.setTitle("내 계좌 입력", for: .normal)
        secondOptionButton.setTitleColor(.black, for: .normal)
        secondOptionButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        secondOptionButton.backgroundColor = .systemGray6
        secondOptionButton.layer.cornerRadius = 7
        secondOptionButton.addTarget(self, action: #selector(secondOptionButtonTapped), for: .touchUpInside)
        optionView.addSubview(secondOptionButton)
        secondOptionButton.snp.makeConstraints { make in
            make.centerY.equalTo(secondOptionIcon)
            make.trailing.equalTo(optionView).offset(-15)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        updatePointsLabel()  // Initial update
    }
    
    func updatePointsLabel() {
        points1Label.text = "\(rewardPoints)P"
    }
    
    @objc func rewardBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func firstOptionButtonTapped() {
        let rewardDonateVC = RewardDonateViewController()
        navigationController?.pushViewController(rewardDonateVC, animated: true)
    }
    
    @objc func secondOptionButtonTapped() {
        let rewardExchangeVC = RewardExchangeViewController()
        navigationController?.pushViewController(rewardExchangeVC, animated: true)
    }
    
    func setRewardPoints(_ newPoints: Int) {
        rewardPoints = newPoints
    }
}
