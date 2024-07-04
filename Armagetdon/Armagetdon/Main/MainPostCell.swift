import UIKit
import SnapKit

class MainPostCell: UITableViewCell {

    static let identifier = "mainPostCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: - 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addAllProperty()
        makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Exit..")
    }
    
    //MARK: - 데이터 받기
    ///썸네일
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    ///제목
    private lazy var mainTitle: UILabel = {
        let t = UILabel()
        t.font = UIFont(name: "Pretendard-Medium", size: 16)
        return t
    }()
    ///닉네임
    private lazy var nickname: UILabel = {
        let t = UILabel()
        t.font = UIFont(name: "Pretendard-Medium", size: 12)
        return t
    }()
    ///랭크 아이콘
    private lazy var rankIcon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    ///신고 아이콘
    private lazy var reportIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "report")
        img.contentMode = .scaleAspectFit
        return img
    }()
    ///하트(추천 아이콘)
    private lazy var likeIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "heart")
        img.contentMode = .scaleAspectFit
        return img
    }()
    ///추천수
    private lazy var likeCount: UILabel = {
        let t = UILabel()
        t.font = UIFont(name: "Pretendard-Medium", size: 10)
        return t
    }()
    
    //MARK: - 스택
    private lazy var userStackGroup: UIStackView = {
        return commonStackView2(spacing: 4)
    }()
    private lazy var middleStackGroup: UIStackView = {
        return commonStackView(spacing: 4)
    }()
    private lazy var likeStackGroup: UIStackView = {
        return commonStackView2(spacing: 2)
    }()
    
    //MARK: - 함수
    ///스택 함수
    private func commonStackView(spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }
    
    private func commonStackView2(spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }
    
    ///스택 뷰에 프로퍼티 추가
    private func addStackProperty() {
        [nickname, rankIcon].forEach {
            self.userStackGroup.addArrangedSubview($0)
        }
        [mainTitle, userStackGroup].forEach {
            self.middleStackGroup.addArrangedSubview($0)
        }
        [likeIcon, likeCount].forEach {
            self.likeStackGroup.addArrangedSubview($0)
        }
    }
    
    ///셀에 프로퍼티 추가
    private func addProperty() {
        [mainImage, middleStackGroup, reportIcon, likeStackGroup].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    ///오토 레이아웃
    private func makeConstraint() {
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(106)
            make.height.equalTo(60)
        }
        middleStackGroup.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(mainImage.snp.right).offset(12)
        }
        reportIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        likeStackGroup.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    ///모든 프로퍼티 생성
    private func addAllProperty() {
        addStackProperty()
        addProperty()
    }
    
    /// UI 설정
    private func setupUI() {
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .systemGray6
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    ///데이터 값 넣기
    public func addData(model: MainPost) {
        self.mainImage.image = model.img
        self.mainTitle.text = model.title
        self.nickname.text = model.nickname
        self.rankIcon.image = model.rankimage
        self.likeCount.text = String(model.recommendCount)
    }
}
