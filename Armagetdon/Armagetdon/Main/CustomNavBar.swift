//
//  CustomNavBar.swift
//  Armagetdon
//
//  Created by 김나연 on 7/4/24.
//

import UIKit
import SnapKit

class CustomNavigationBar: UINavigationBar {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "100p"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Medium", size: 12)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "point")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(logoImageView)
        addSubview(pointsLabel)
        addSubview(iconImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(6)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(6)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.right.equalTo(pointsLabel.snp.left).offset(-4)
            make.size.equalTo(CGSize(width: 24, height: 24))
            make.centerY.equalTo(pointsLabel)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 48
        return newSize
    }
}
