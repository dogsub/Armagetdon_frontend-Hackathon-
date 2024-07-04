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
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.layer.borderWidth = 1
        sv.isScrollEnabled = true
        sv.delegate = self
        return sv
    }()
    
    ///content view
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .white
        return content
    }()
    
    ///label
    private lazy var volunteerLabel: UILabel = {
        let volunteer = UILabel()
        volunteer.text = "요즘 HOT한 선행 구경하기"
        volunteer.font = UIFont(name: "Pretendard-Bold.ttf", size: 20)
        return volunteer
    }()
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "현재 선플을 달고 있는 사람들을 \n구경해보세요👀"
        title.font = UIFont(name: "Pretendard-Bold", size: 20)
        return title
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    //MARK: - Snapkit
    func setNavBar() {
        //navBar에 init
    }
    func setUI() {
        //self.view.어쩌구 하는 곳
    }
    func setAttributes() {
        //스냅킷 쓰는 곳
    }
}
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY>0{
            UIView.animate(withDuration: 0.3){
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        } else {
            UIView.animate(withDuration: 0.3){
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
}

