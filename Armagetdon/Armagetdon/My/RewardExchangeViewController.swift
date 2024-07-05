import UIKit
import SnapKit

class RewardExchangeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let backButton = UIButton()
    let titleIcon = UIImageView()
    let titleLabel = UILabel()
    let pointsTextField = UITextField()
    let accountTextField = UITextField()
    let bankSelectionView = UIView()
    let bankSelectionLabel = UILabel()
    let bankSelectionArrow = UIImageView()
    let bankSelectionDropdown = UITableView()
    let bankOptions = ["카리나 은행", "윈터 은행", "닝닝 은행", "지젤 은행"]
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
        titleIcon.image = UIImage(named: "rewardMoney2")
        view.addSubview(titleIcon)
        titleIcon.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(45)
            make.leading.equalTo(view).offset(13)
            make.width.height.equalTo(30)
        }
        
        // Title Label
        titleLabel.text = "전환할 리워드의 금액과\n계좌를 입력해주세요"
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
        
        // Account TextField
        accountTextField.borderStyle = .roundedRect
        accountTextField.placeholder = "계좌번호 입력"
        view.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { make in
            make.top.equalTo(pointsTextField.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        accountTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
        // Bank Selection View
        bankSelectionView.layer.borderWidth = 1
        bankSelectionView.layer.borderColor = UIColor.lightGray.cgColor
        bankSelectionView.layer.cornerRadius = 5
        bankSelectionView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bankSelectionTapped))
        bankSelectionView.addGestureRecognizer(tapGesture)
        view.addSubview(bankSelectionView)
        bankSelectionView.snp.makeConstraints { make in
            make.top.equalTo(accountTextField.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(40)
        }
        
        // Bank Selection Label
        bankSelectionLabel.text = "은행선택"
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
        exchangeButton.setTitle("전환하기", for: .normal)
        exchangeButton.setTitleColor(.white, for: .normal)
        exchangeButton.backgroundColor = UIColor(hex: "6A48E7", alpha: 1.0)
        exchangeButton.layer.cornerRadius = 10
        exchangeButton.isEnabled = false
        exchangeButton.alpha = 0.3
        exchangeButton.addTarget(self, action: #selector(exchangeButtonTapped), for: .touchUpInside)
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
                          !(accountTextField.text?.isEmpty ?? true) &&
                          bankOptions.contains(bankSelectionLabel.text ?? "")
        
        exchangeButton.isEnabled = isFormValid
        exchangeButton.alpha = isFormValid ? 1.0 : 0.3
    }
    
    @objc func exchangeButtonTapped() {
        let rewardExchangeAnimationVC = RewardExchangeAnimationViewController()
        navigationController?.pushViewController(rewardExchangeAnimationVC, animated: true)
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

