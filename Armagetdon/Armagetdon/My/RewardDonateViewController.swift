import UIKit
import SnapKit

class RewardDonateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let backButton = UIButton()
    let titleIcon = UILabel()
    let titleLabel = UILabel()
    let pointsTextField = UITextField()
    let bankSelectionView = UIView()
    let bankSelectionLabel = UILabel()
    let bankSelectionArrow = UIImageView()
    let bankSelectionDropdown = UITableView()
    let bankOptions = ["광야 나눔재단", "나비스 병원", "블랙맘바 환경단체", "넥스트 월드 비전"]
    let exchangeButton = UIButton()
    var isDropdownVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationItem.hidesBackButton = true
        
        // Back Button
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(10)
            make.width.height.equalTo(30)
        }
        
        // title Icon
        titleIcon.text = "🌱"
        titleIcon.font = UIFont.boldSystemFont(ofSize: 20)
        titleIcon.numberOfLines = 2
        view.addSubview(titleIcon)
        titleIcon.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(45)
            make.leading.equalTo(view).offset(15)
            make.width.height.equalTo(30)
        }
        
        // Title Label
        titleLabel.text = "기부하실 리워드의 금액과\n기부처를 선택해주세요"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleIcon.snp.bottom).offset(13)
            make.leading.equalTo(view).offset(20)
        }
        
        // Points TextField
        pointsTextField.borderStyle = .roundedRect
        pointsTextField.placeholder = "0P"
        view.addSubview(pointsTextField)
        pointsTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        pointsTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
        // Bank Selection View
        bankSelectionView.layer.borderWidth = 1
        bankSelectionView.layer.borderColor = UIColor.lightGray.cgColor
        bankSelectionView.layer.cornerRadius = 5
        bankSelectionView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bankSelectionTapped))
        bankSelectionView.addGestureRecognizer(tapGesture)
        view.addSubview(bankSelectionView)
        bankSelectionView.snp.makeConstraints { make in
            make.top.equalTo(pointsTextField.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        
        // Bank Selection Label
        bankSelectionLabel.text = "기부처 선택"
        bankSelectionLabel.textColor = .lightGray
        bankSelectionView.addSubview(bankSelectionLabel)
        bankSelectionLabel.snp.makeConstraints { make in
            make.leading.equalTo(bankSelectionView).offset(10)
            make.centerY.equalTo(bankSelectionView)
        }
        
        // Bank Selection Arrow
        bankSelectionArrow.image = UIImage(systemName: "chevron.down")
        bankSelectionArrow.tintColor = .gray
        bankSelectionView.addSubview(bankSelectionArrow)
        bankSelectionArrow.snp.makeConstraints { make in
            make.trailing.equalTo(bankSelectionView).offset(-10)
            make.centerY.equalTo(bankSelectionView)
        }
        
        // Bank Selection Dropdown
        bankSelectionDropdown.isHidden = true
        bankSelectionDropdown.layer.borderWidth = 1
        bankSelectionDropdown.layer.borderColor = UIColor.lightGray.cgColor
        bankSelectionDropdown.layer.cornerRadius = 5
        bankSelectionDropdown.delegate = self
        bankSelectionDropdown.dataSource = self
        view.addSubview(bankSelectionDropdown)
        bankSelectionDropdown.snp.makeConstraints { make in
            make.top.equalTo(bankSelectionView.snp.bottom).offset(5)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(0) // 초기에는 높이를 0으로 설정
        }
        
        // Exchange Button
        exchangeButton.setTitle("기부하기", for: .normal)
        exchangeButton.setTitleColor(.white, for: .normal)
        exchangeButton.backgroundColor = UIColor(hex: "6A48E7", alpha: 1.0)
        exchangeButton.layer.cornerRadius = 10
        exchangeButton.isEnabled = false
        exchangeButton.alpha = 0.3
        exchangeButton.addTarget(self, action: #selector(donateButtonTapped), for: .touchUpInside)
        view.addSubview(exchangeButton)
        exchangeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func bankSelectionTapped() {
        isDropdownVisible.toggle()
        bankSelectionDropdown.isHidden = !isDropdownVisible
        
        bankSelectionDropdown.snp.updateConstraints { make in
            make.height.equalTo(isDropdownVisible ? 200 : 0)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func bankOptionSelected(_ sender: UIButton) {
        let selectedBank = bankOptions[sender.tag]
        bankSelectionLabel.text = selectedBank
        bankSelectionLabel.textColor = .black
        bankSelectionDropdown.isHidden = true
        isDropdownVisible = false
        textFieldsChanged()
    }
    
    @objc func textFieldsChanged() {
        let isFormValid = !(pointsTextField.text?.isEmpty ?? true) &&
                          bankSelectionLabel.text != "기부처 선택"
        
        exchangeButton.isEnabled = isFormValid
        exchangeButton.alpha = isFormValid ? 1.0 : 0.3
    }
    
    @objc func donateButtonTapped() {
        // 기부하기 버튼을 눌렀을 때의 동작을 여기에 구현합니다.
        let rewardDonateAnimationVC = RewardDonateAnimationViewController()
        navigationController?.pushViewController(rewardDonateAnimationVC, animated: true)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = bankOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBank = bankOptions[indexPath.row]
        bankSelectionLabel.text = selectedBank
        bankSelectionLabel.textColor = .black
        bankSelectionTapped() // 선택 후 목록을 숨김
        textFieldsChanged()
    }
}
