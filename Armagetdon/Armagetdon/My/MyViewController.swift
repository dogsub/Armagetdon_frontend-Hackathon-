import UIKit
import SnapKit
import Alamofire

class MyViewController: UIViewController {

    let appIcon = UIImageView()
    let nameLabel = UILabel()
    let levelGuideButton = UIButton()
    let levelView = UIView()
    let levelNowLabel = UILabel()
    let levelNextLabel = UILabel()
    let levelProgressBar = UIImageView()
    let levelBadge = UIImageView()
    let rewardLabel = UILabel()
    let rewardExchangeButton = UIButton()
    let uploadedListLabel = UILabel()
    let uploadedListButton = UIButton()
    let noticeLabel = UILabel()
    let noticeButton = UIButton()
    let faqLabel = UILabel()
    let faqButton = UIButton()
    let logoutLabel = UILabel()
    let logoutButton = UIButton()
    let deleteAccountLabel = UILabel()
    let deleteAccountButton = UIButton()
    
    var rewardPoints: Int = 0 // Variable to hold reward points
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        fetchMyPage(memberId: "1") // Example memberId
    }
    
    func setupUI() {
        // 기존의 UI 설정 코드를 여기에 넣습니다.
        // 앱 아이콘
        appIcon.image = UIImage(systemName: "circle.fill")
        view.addSubview(appIcon)
        appIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(view).offset(20)
            make.width.height.equalTo(30)
        }
        
        // 닉네임 라벨
        nameLabel.text = "닉네임1234"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIcon.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(20)
        }
        
        // 등급 안내 버튼
        levelGuideButton.setTitle("등급 안내", for: .normal)
        levelGuideButton.setTitleColor(.black, for: .normal)
        levelGuideButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        levelGuideButton.backgroundColor = .systemGray6
        levelGuideButton.layer.cornerRadius = 7
        view.addSubview(levelGuideButton)
        levelGuideButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.equalTo(70)
            make.height.equalTo(25)
        }
        
        levelGuideButton.addTarget(self, action: #selector(levelGuideButtonTapped), for: .touchUpInside)

        // 등급 뷰
        levelView.backgroundColor = UIColor(hex: "6A48E7", alpha: 1.0)
        levelView.layer.cornerRadius = 10.0
        view.addSubview(levelView)
        levelView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(100)
        }
        
        // 등급 단계
        levelNowLabel.font = UIFont.systemFont(ofSize: 12)
        levelNowLabel.textColor = .white
        levelNowLabel.numberOfLines = 0
        levelView.addSubview(levelNowLabel)
        levelNowLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(levelView).inset(10)
        }

        // 다음 등급까지 남은 거리
        levelNextLabel.font = UIFont.boldSystemFont(ofSize: 15)
        levelNextLabel.textColor = .white
        levelNextLabel.numberOfLines = 0
        levelView.addSubview(levelNextLabel)
        levelNextLabel.snp.makeConstraints { make in
            make.top.equalTo(levelNowLabel.snp.bottom).offset(5)
            make.leading.equalTo(levelView).inset(10)
        }
        
        levelProgressBar.image = UIImage(named: "progressBar")
        levelView.addSubview(levelProgressBar)
        levelProgressBar.snp.makeConstraints { make in
            make.top.equalTo(levelNextLabel.snp.bottom).offset(20)
            make.leading.equalTo(levelView).inset(10)
        }
        
        // 등급 뱃지
        levelBadge.image = UIImage(systemName: "star.fill") // 적절한 이미지로 교체
        levelBadge.clipsToBounds = true
        levelView.addSubview(levelBadge)
        levelBadge.snp.makeConstraints { make in
            make.centerY.equalTo(levelView)
            make.trailing.equalTo(levelView).inset(30)
            make.width.height.equalTo(60)
        }

        // 현재 유저의 Reward
        rewardLabel.font = UIFont.boldSystemFont(ofSize: 18)
        rewardLabel.textColor = .black
        view.addSubview(rewardLabel)
        rewardLabel.snp.makeConstraints { make in
            make.top.equalTo(levelView.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(20)
        }
        
        // Reward 전환 버튼
        rewardExchangeButton.setTitle("리워드 전환", for: .normal)
        rewardExchangeButton.setTitleColor(.black, for: .normal)
        rewardExchangeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        rewardExchangeButton.backgroundColor = .systemGray6
        rewardExchangeButton.layer.cornerRadius = 7
        view.addSubview(rewardExchangeButton)
        rewardExchangeButton.snp.makeConstraints { make in
            make.centerY.equalTo(rewardLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.equalTo(90)
            make.height.equalTo(25)
        }
        
        rewardExchangeButton.addTarget(self, action: #selector(rewardExchangeButtonTapped), for: .touchUpInside)
        
        // 자신이 업로드한 선플 리스트
        uploadedListLabel.text = "내가 업로드한 선플"
        view.addSubview(uploadedListLabel)
        uploadedListLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardLabel.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(20)
        }
        
        // 자신이 업로드한 선플 리스트 이동
        uploadedListButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        uploadedListButton.tintColor = .black
        view.addSubview(uploadedListButton)
        uploadedListButton.snp.makeConstraints { make in
            make.centerY.equalTo(uploadedListLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.height.equalTo(30)
        }
        
        // 공지사항
        noticeLabel.text = "공지사항"
        view.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(uploadedListLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
        }
        
        // 공지사항 이동
        noticeButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        noticeButton.tintColor = .black
        view.addSubview(noticeButton)
        noticeButton.snp.makeConstraints { make in
            make.centerY.equalTo(noticeLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.height.equalTo(30)
        }
        
        // 자주 묻는 질문
        faqLabel.text = "자주 묻는 질문"
        view.addSubview(faqLabel)
        faqLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
        }
        
        // 자주 묻는 질문 이동
        faqButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        faqButton.tintColor = .black
        view.addSubview(faqButton)
        faqButton.snp.makeConstraints { make in
            make.centerY.equalTo(faqLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.height.equalTo(30)
        }
        
        // 로그아웃
        logoutLabel.text = "로그아웃"
        view.addSubview(logoutLabel)
        logoutLabel.snp.makeConstraints { make in
            make.top.equalTo(faqLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
        }
        
        // 로그아웃 이동
        logoutButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        logoutButton.tintColor = .black
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.centerY.equalTo(logoutLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.height.equalTo(30)
        }
        
        // 회원탈퇴
        deleteAccountLabel.text = "회원탈퇴"
        view.addSubview(deleteAccountLabel)
        deleteAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(logoutLabel.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(20)
        }
        
        // 회원탈퇴 이동
        deleteAccountButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        deleteAccountButton.tintColor = .black
        view.addSubview(deleteAccountButton)
        deleteAccountButton.snp.makeConstraints { make in
            make.centerY.equalTo(deleteAccountLabel)
            make.trailing.equalTo(view).offset(-30)
            make.width.height.equalTo(30)
        }
    }
    
    func fetchMyPage(memberId: String) {
        NetworkManager.shared.getMyPage(memberId: memberId) { result in
            switch result {
            case .success(let response):
                if let myPage = response.result {
                    DispatchQueue.main.async {
                        self.nameLabel.text = myPage.nickname
                        self.rewardPoints = myPage.reward // Set reward points
                        self.rewardLabel.text = "\(myPage.reward)P"
                        self.levelNowLabel.text = "\(myPage.level) 단계"
                        if myPage.level == "광야" {
                            self.levelNextLabel.text = "Hi, Naevis. 광야로 온 걸 축하해요"
                        } else {
                            self.levelNextLabel.text = "Next Level까지 \(myPage.leftAltitude)km 남았어요"
                        }
                    }
                } else {
                    print("결과 없음")
                }
            case .failure(let error):
                print("요청 오류: \(error)")
            }
        }
    }

    @objc func levelGuideButtonTapped() {
        let alertVC = GFAlertLevel()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }

    @objc func rewardExchangeButtonTapped() {
        let rewardVC = RewardViewController()
        rewardVC.setRewardPoints(rewardPoints) // Pass the reward points
        navigationController?.pushViewController(rewardVC, animated: true)
    }
}
