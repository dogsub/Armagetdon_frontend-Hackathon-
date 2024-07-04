//
//  ViewController.swift
//  Armagetdon
//
//  Created by 김나연 on 7/4/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    //MARK: - UI
    ///scroll view
    private lazy var mainScrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    ///label
    private lazy var adLabel: UILabel = {
        let ad = UILabel()
        ad.text = "요즘 HOT한 선행 참여하기"
        ad.font = UIFont(name: "Pretendard-Bold.ttf", size: 20)
        return ad
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "같이 선플 달고 GET 돈 해요"
        title.font = UIFont(name: "Pretendard-Bold", size: 20)
        return title
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}

