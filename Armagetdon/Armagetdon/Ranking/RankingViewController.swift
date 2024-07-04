import UIKit
import SnapKit

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rankScrollTableView = UITableView()
    
    // 더미 데이터 생성
    let profileData: [(image: UIImage?, badge: UIImage?, nickname: String, info: String)] = (1...100).map {
            if $0 == 1 {
                return (image: UIImage(named: "Rectangle"), badge: UIImage(named:"badge05"), nickname: "닉네임\($0)", info: "\(1000 - $0)m")
            } else if $0 == 2 {
                return (image: UIImage(named: "Rectangle-2"), badge: UIImage(named:"badge04"), nickname: "닉네임\($0)", info: "\(1000 - $0)m")
            } else if $0 == 3 {
                return (image: UIImage(named: "Rectangle-3"), badge: UIImage(named:"badge02"), nickname: "닉네임\($0)", info: "\(1000 - $0)m")
            } else {
                return (image: nil, badge: UIImage(named:"badge01"), nickname: "닉네임\($0)", info: "\(1000 - $0)m")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rankTitleLabel = UILabel()
        rankTitleLabel.text = "TOP 100"
        rankTitleLabel.textColor = .white
        rankTitleLabel.font = UIFont(name: "Pretendard-ExtraBold", size: 22)
        view.addSubview(rankTitleLabel)
        
        // SnapKit을 사용하여 UILabel의 레이아웃 설정
        rankTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        // UITableView 설정
        rankScrollTableView.dataSource = self
        rankScrollTableView.delegate = self
        rankScrollTableView.backgroundColor = .clear
        rankScrollTableView.register(RankCell.self, forCellReuseIdentifier: "RankCell")
        view.addSubview(rankScrollTableView)
        
        // SnapKit을 사용하여 UITableView의 레이아웃 설정
        rankScrollTableView.snp.makeConstraints { make in
            make.top.equalTo(rankTitleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        // 그래디언트 레이어 생성
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex:"6F65A8").cgColor,
            UIColor(hex:"4A4A94").cgColor,
            UIColor(hex:"2E2E88").cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        // 레이아웃 후 그래디언트 레이어 프레임 설정
        view.layoutIfNeeded()
        gradientLayer.frame = view.bounds
        
        
        // 하단의 둥글게 깎인 버튼 생성
        let profileButton = UIButton()
        profileButton.backgroundColor = .white
        profileButton.layer.cornerRadius = 33
        profileButton.layer.masksToBounds = true
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        view.addSubview(profileButton)
        
        profileButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-110)
            make.height.equalTo(70)
        }
        
        // 프로필 이미지, 닉네임, info 추가
        let myRankLabel = UILabel()
        myRankLabel.text = "992"
        myRankLabel.textColor = .black
        myRankLabel.font = UIFont.systemFont(ofSize: 16)
        profileButton.addSubview(myRankLabel)
        
        let myNicknameLabel = UILabel()
        myNicknameLabel.text = "닉네임1234"
        myNicknameLabel.textColor = .black
        myNicknameLabel.font = UIFont(name: "Pretendard-Medium", size: 18)
        profileButton.addSubview(myNicknameLabel)
        
        let myBadgeImageView = UIImageView(image: UIImage(named: "badge01"))
        profileButton.addSubview(myBadgeImageView)
        
        let myInfoLabel = UILabel()
        myInfoLabel.text = "31m"
        myInfoLabel.textColor = .darkGray
        myInfoLabel.font = UIFont(name: "Pretendard-Medium", size: 18)
        profileButton.addSubview(myInfoLabel)
        
        myRankLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        myBadgeImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(myNicknameLabel).offset(-25)
            make.left.equalTo(myNicknameLabel)
            make.width.height.equalTo(18)
        }
        
        myNicknameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-17)
            make.left.equalTo(myRankLabel).offset(40)
        }
        
        myInfoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
    }
    
    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankCell", for: indexPath) as! RankCell
        let data = profileData[indexPath.row]
        cell.configure(image: data.image, badge: data.badge, nickname: data.nickname, info: data.info, rank: indexPath.row + 1)
        return cell
    }
    // UITableViewDelegate 메서드 - 셀의 높이를 지정
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70 // 원하는 높이로 설정
        }
    
    // 프로필 버튼이 눌렸을 때 호출되는 메서드
    @objc func profileButtonTapped() {
        print("버튼눌림")
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

// 커스텀 테이블 뷰 셀
class RankCell: UITableViewCell {
    
    let profileImageView = UIImageView()
    let rankLabel = UILabel()
    let nicknameLabel = UILabel()
    let badgeImageView = UIImageView()
    let infoLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 셀의 배경색을 투명하게 설정
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        // UILabel 텍스트 색상 설정
        nicknameLabel.textColor = .white
        nicknameLabel.font = UIFont(name: "Pretendard-Medeum", size: 18)
        infoLabel.textColor = .white
        infoLabel.font = UIFont(name: "Pretendard-Medeum", size: 18)
        rankLabel.textColor = .white
        rankLabel.font = UIFont(name: "Pretendard-Bold", size: 16)
        rankLabel.textAlignment = .center
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(badgeImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(28)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(42)
        }
        
        rankLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profileImageView.snp.right).offset(16)
            //make.right.equalToSuperview().offset(-250)
        }
        
        badgeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(nicknameLabel.snp.right)
            make.width.height.equalTo(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-28)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?, badge: UIImage?, nickname: String, info: String, rank: Int) {
        if let image = image, rank <= 3 {
            profileImageView.isHidden = false
            rankLabel.isHidden = true
            profileImageView.image = image
        } else {
            profileImageView.isHidden = true
            rankLabel.isHidden = false
            rankLabel.text = "\(rank)"
        }
        nicknameLabel.text = nickname
        badgeImageView.image = badge
        infoLabel.text = info
    }
}

// 새 화면으로 이동할 때 표시할 ViewController
class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Profile View"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// UIColor 확장 메서드 추가
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
