//
//  DetailPostViewController.swift
//  Armagetdon
//
//  Created by 이상엽 on 7/5/24.
//

import UIKit
import SnapKit
import WebKit

class DetailPostViewController: UIViewController {
    
    // UI 요소들
    let backButton = UIButton(type: .system)
    let reportButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let heartButton = UIButton()
    let heartCountLabel = UILabel()
    let postImageView = UIImageView()
    let goToCommentsButton = UIButton()

    // 더미 데이터
    let postTitle = "게시글 제목"
    let authorName = "작성자 이름"
    var heartCount = 42
    var isHeartFilled = false // 하트가 채워졌는지 여부
    let postImageURL = "https://example.com/image.jpg" // 이미지 URL 예제

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        loadPostData()
    }
    
    func setupUI() {
        // 뒤로가기 버튼 설정
        let backImage = UIImage(systemName: "chevron.backward")
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        // 신고하기 버튼 설정
        let reportImage = UIImage(named: "siren")
        reportButton.setImage(reportImage, for: .normal)
        reportButton.tintColor = .gray
        reportButton.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
        view.addSubview(reportButton)
        
        reportButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.right.equalToSuperview().offset(-10)
        }
        
        // 게시글 제목 설정
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        // 작성자 이름 설정
        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.textColor = .gray
        view.addSubview(authorLabel)
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        // 하트 버튼 설정
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        heartButton.setImage(heartImage, for: .normal)
        heartButton.tintColor = .red
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        view.addSubview(heartButton)
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        // 하트 개수 라벨 설정
        heartCountLabel.font = UIFont.systemFont(ofSize: 16)
        heartCountLabel.textColor = .black
        view.addSubview(heartCountLabel)
        
        heartCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton.snp.centerY)
            make.left.equalTo(heartButton.snp.right).offset(10)
        }
        
        // 게시글 이미지 뷰 설정
        postImageView.contentMode = .scaleAspectFit
        view.addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(300) // 원하는 높이로 설정
        }
        
        // 긴 직사각형 버튼 설정
        goToCommentsButton.setTitle("나도 선플달러 가기", for: .normal)
        goToCommentsButton.backgroundColor = UIColor(hex:"6A48E7")//6A48E7
        goToCommentsButton.setTitleColor(.white, for: .normal)
        goToCommentsButton.layer.cornerRadius = 10
        goToCommentsButton.addTarget(self, action: #selector(goToCommentsButtonTapped), for: .touchUpInside)
        view.addSubview(goToCommentsButton)
        
        goToCommentsButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
        }
    }
    
    func loadPostData() {
        // 서버에서 데이터 받아오는 부분 (여기서는 더미 데이터 사용)
        titleLabel.text = postTitle
        authorLabel.text = authorName
        heartCountLabel.text = "\(heartCount)"
        
        if let url = URL(string: postImageURL) {
            loadImage(from: url)
        }
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.postImageView.image = image
                }
            }
        }.resume()
    }

    @objc func backButtonTapped() {
        // 뒤로가기 동작
        navigationController?.popViewController(animated: true)
    }
    
    @objc func heartButtonTapped() {
            // 하트 버튼 눌림 동작
            isHeartFilled.toggle()
            heartCount += isHeartFilled ? 1 : -1
            heartCountLabel.text = "\(heartCount)"
            let heartImage = UIImage(systemName: isHeartFilled ? "heart.fill" : "heart")
            heartButton.setImage(heartImage, for: .normal)
        }
    
    @objc func goToCommentsButtonTapped() {
        // "나도 선플달러 가기" 버튼 눌림 동작
        let commentsViewController = CommentsViewController()
        navigationController?.pushViewController(commentsViewController, animated: true)
    }
    @objc func reportButtonTapped() {
            // 신고하기 버튼 눌림 동작
            let reportViewController = ReportViewController()
            reportViewController.modalPresentationStyle = .overFullScreen
            present(reportViewController, animated: true, completion: nil)
        }
    
}

// 댓글 화면을 표시할 ViewController
class CommentsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Comments View"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
// 신고하기 모달 화면을 표시할 ViewController
class ReportViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let modalView = UIView()
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 24
        view.addSubview(modalView)
        
        modalView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(310) // 정사각형으로 설정
            make.width.equalTo(334)
                }
        
        let reportButton = UIButton()
        reportButton.setTitle("신고하기", for: .normal)
        reportButton.backgroundColor = UIColor(hex:"6A48E7")
        reportButton.setTitleColor(.white, for: .normal)
        reportButton.layer.cornerRadius = 10
        reportButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(reportButton)
        
        reportButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(modalView).offset(-20)
            make.width.equalTo(282)
            make.height.equalTo(45)
        }
    
        // 모달창 닫기 버튼
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(modalView).offset(30)
            make.right.equalTo(modalView).offset(-20)
        }
        //신고사유
        let reportSelectLabel = UILabel()
        reportSelectLabel.text = "신고 사유를 선택해주세요"
        reportSelectLabel.font = UIFont(name: "Pretendard-Bold", size: 20)
        view.addSubview(reportSelectLabel)
        
        reportSelectLabel.snp.makeConstraints{ make in
            make.top.equalTo(closeButton)
            make.left.equalTo(modalView).offset(20)
        }
        
        let reportButton1 = UIButton()
        reportButton1.setImage(UIImage(systemName: "square"), for: .normal)
        reportButton1.tintColor = .gray
        reportButton1.addTarget(self, action: #selector(reportOptionButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(reportButton1)
        view.addSubview(reportButton1)
        let reportSelect1stLabel = UILabel()
        reportSelect1stLabel.font = UIFont(name: "Pretendard-Midium", size: 14)
        reportSelect1stLabel.text = "선플이 아님"
        view.addSubview(reportSelect1stLabel)
        
        reportButton1.snp.makeConstraints{ make in
            make.top.equalTo(reportSelectLabel).offset(45)
            make.left.equalTo(modalView).offset(20)
        }
        reportSelect1stLabel.snp.makeConstraints{ make in
            make.top.equalTo(reportButton1)
            make.left.equalTo(reportButton1).offset(25)
        }
        
        let reportButton2nd = UIButton()
        reportButton2nd.setImage(UIImage(systemName: "square"), for: .normal)
        reportButton2nd.tintColor = .gray
        reportButton2nd.addTarget(self, action: #selector(reportOptionButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(reportButton2nd)
        view.addSubview(reportButton2nd)
        let reportSelect2ndLabel = UILabel()
        reportSelect2ndLabel.font = UIFont(name: "Pretendard-Midium", size: 14)
        reportSelect2ndLabel.text = "관련이 없는 콘텐츠"
        view.addSubview(reportSelect2ndLabel)
        
        reportButton2nd.snp.makeConstraints{ make in
            make.top.equalTo(reportButton1).offset(40)
            make.left.equalTo(reportButton1)
        }
        reportSelect2ndLabel.snp.makeConstraints{ make in
            make.top.equalTo(reportButton2nd)
            make.left.equalTo(reportButton2nd).offset(25)
        }
        
        let reportButton3rd = UIButton()
        reportButton3rd.setImage(UIImage(systemName: "square"), for: .normal)
        reportButton3rd.tintColor = .gray
        reportButton3rd.addTarget(self, action: #selector(reportOptionButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(reportButton3rd)
        view.addSubview(reportButton3rd)
        let reportSelect3rdLabel = UILabel()
        reportSelect3rdLabel.font = UIFont(name: "Pretendard-Midium", size: 14)
        reportSelect3rdLabel.text = "불충분한 댓글정보(작성자 / 본문 등)"
        view.addSubview(reportSelect3rdLabel)
        
        reportButton3rd.snp.makeConstraints{ make in
            make.top.equalTo(reportButton2nd).offset(40)
            make.left.equalTo(reportButton2nd)
        }
        reportSelect3rdLabel.snp.makeConstraints{ make in
            make.top.equalTo(reportButton3rd)
            make.left.equalTo(reportButton3rd).offset(25)
        }
        
        let reportButton4th = UIButton()
        reportButton4th.setImage(UIImage(systemName: "square"), for: .normal)
        reportButton4th.tintColor = .gray
        reportButton4th.addTarget(self, action: #selector(reportOptionButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(reportButton4th)
        let reportSelect4thLabel = UILabel()
        reportSelect4thLabel.font = UIFont(name: "Pretendard-Midium", size: 14)
        reportSelect4thLabel.text = "부적절한 링크가 연결됨"
        view.addSubview(reportSelect4thLabel)
        
        reportButton4th.snp.makeConstraints{ make in
            make.top.equalTo(reportButton3rd).offset(40)
            make.left.equalTo(reportButton3rd)
        }
        reportSelect4thLabel.snp.makeConstraints{ make in
            make.top.equalTo(reportButton4th)
            make.left.equalTo(reportButton4th).offset(25)
        }
        
        
    }
    @objc func closeButtonTapped() {
           dismiss(animated: true, completion: nil)
       }
    @objc func reportOptionButtonTapped(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        sender.tintColor = UIColor(hex:"6A48E7")
    }
    
   }
