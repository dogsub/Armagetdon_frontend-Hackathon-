//
//  RewardExchangeAnimationViewController.swift
//  Armagetdon
//
//  Created by 김동섭 on 7/5/24.
//

import UIKit
import SnapKit

class RewardDonateAnimationViewController: UIViewController {

    let sendingMoneyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "6A48E7", alpha: 1.0)
        
        self.navigationItem.hidesBackButton = true
        
        // 이미지 설정
        let moneyImageView = UIImageView(image: UIImage(named: "rewardDonate"))
        view.addSubview(moneyImageView)
        moneyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(100) // 이미지 크기에 맞게 조절
            make.height.equalTo(100) // 이미지 크기에 맞게 조절
        }
        
        // 텍스트 레이블 설정
        sendingMoneyLabel.text = "마음을 전하는 중..."
        sendingMoneyLabel.textColor = .white
        sendingMoneyLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(sendingMoneyLabel)
        sendingMoneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyImageView.snp.bottom).offset(20)
        }
        
        // 애니메이션 설정
        animateLabel()
        
        // 3초 후에 RewardViewController로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToRewardViewController()
        }
    }
    
    func animateLabel() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.sendingMoneyLabel.alpha = 0
        }, completion: nil)
    }
    
    func navigateToRewardViewController() {
        if let navigationController = self.navigationController {
            for viewController in navigationController.viewControllers {
                if let rewardViewController = viewController as? RewardViewController {
                    navigationController.popToViewController(rewardViewController, animated: true)
                    return
                }
            }
        }
    }
}
