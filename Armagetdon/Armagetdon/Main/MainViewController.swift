//
//  ViewController.swift
//  Armagetdon
//
//  Created by 김나연 on 7/4/24.
//

import UIKit

class MainViewController: UIViewController {
    let thumbnailData = MainItem.thumbnailDataList
    let mainpostData = MainItem.mainpostDataList
    
    // MARK: - UI
    /// navigation bar
    private lazy var customNavBar: CustomNavigationBar = {
        let nav = CustomNavigationBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()
    
    /// scroll view
    private lazy var mainScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        sv.delegate = self
        return sv
    }()
    
    /// content view
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = UIColor(named: "Mbackground")
        return content
    }()
    
    /// labels
    private lazy var thumbnailLabel: UILabel = {
        let th = UILabel()
        th.text = "요즘 HOT한 선행 구경하기"
        th.font = UIFont(name: "Pretendard-Bold", size: 20)
        th.textColor = UIColor(named: "Mblack")
        return th
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "현재 선플을 달고 있는 사람들을 \n구경해보세요👀"
        title.font = UIFont(name: "Pretendard-Bold", size: 20)
        title.textColor = UIColor(named: "Mblack")
        title.numberOfLines = 0
        return title
    }()
    
    // MARK: - Collection View
    private lazy var thumbnailView: UICollectionView = {
        let lo = UICollectionViewFlowLayout()
        lo.scrollDirection = .horizontal
        lo.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lo)
        cv.dataSource = self
        cv.delegate = self
        cv.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        cv.tag = 1
        return cv
    }()
    
    // MARK: - Table View
    private lazy var mainpostView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(MainPostCell.self, forCellReuseIdentifier: MainPostCell.identifier)
        tv.tag = 2
        tv.separatorStyle = .none
        return tv
    }()
    
    // MARK: - Floating Button
        private lazy var floatingButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "floating button"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 2
            button.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
            return button
        }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUI()
        setConstraints()
    }
    
    // MARK: - Setup UI
    func setUI() {
        self.view.addSubview(mainScrollView)
        self.view.addSubview(floatingButton)
        mainScrollView.addSubview(contentView)
        
        contentView.addSubview(thumbnailLabel)
        contentView.addSubview(thumbnailView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainpostView)
        self.view.addSubview(customNavBar)
    }
    
    // MARK: - Set Constraints
    func setConstraints() {
        customNavBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(48)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(mainScrollView.snp.width)
        }
        
        thumbnailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(94)
            make.leading.equalToSuperview().offset(12)
        }
        
        thumbnailView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(200) // Adjust height as needed
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(12)
        }
        
        mainpostView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(mainpostData.count * 114) // Adjust height as needed
        }
        floatingButton.snp.makeConstraints { make in
            make.width.height.greaterThanOrEqualTo(60)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-4)
        }
    }
    //MARK: - Function
    @objc func floatingButtonTapped() {
        // Handle floating button tap
        let regVC = RegisterViewController()
        regVC.modalPresentationStyle = .fullScreen
        self.present(regVC, animated: true, completion: nil)
    }
}

// MARK: - Extension: UIScrollViewDelegate
 
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Extension: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return thumbnailData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as? ThumbnailCell else { return UICollectionViewCell() }
            cell.configure(model: thumbnailData[indexPath.item], radius: 20)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            let ad = thumbnailData[indexPath.item]
            let height = collectionView.bounds.height
            let aspectRatio = (ad.img?.size.width ?? 1) / (ad.img?.size.height ?? 1)
            return CGSize(width: height * aspectRatio, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }


}

// MARK: - Extension: UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainpostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPostCell.identifier, for: indexPath) as? MainPostCell else {
            return UITableViewCell()
        }
        cell.addData(model: mainpostData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection
    }
}
