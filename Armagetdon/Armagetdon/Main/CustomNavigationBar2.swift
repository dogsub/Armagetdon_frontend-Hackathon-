//
//  CustomNavBar2.swift
//  Armagetdon
//
//  Created by 김나연 on 7/5/24.
//

import Foundation
import UIKit
import SnapKit

class CustomNavigationBar2: UINavigationBar {
    
    private let previousBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        btn.tintColor = UIColor(named: "Bbutton")
        return btn
    }()
    private let progressbar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "progress1")
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
        addSubview(progressbar)
        previousBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(-32)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        progressbar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 48
        return newSize
    }
}
