//
//  VolunteerCell.swift
//  Armagetdon
//
//  Created by 김나연 on 7/4/24.
//

import UIKit
import SnapKit

class ThumbnailCell: UICollectionViewCell {
    static let identifier = "thumbnailCell"
    override init(frame: CGRect){
        super.init(frame: frame)
        makeConstraints()
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    public lazy var adImg: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.layer.masksToBounds = true
        return v
    }()
    public lazy var adImgName: UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        l.textColor = .black
        l.textAlignment = .center
        l.numberOfLines = 0 //자동 줄바꿈
        l.lineBreakMode = .byWordWrapping //단어 단위로
        return l
    }()
    public func addComponent(){
        self.addSubview(adImg)
    }
    public func makeConstraints(){
        addComponent()
        adImg.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    public func configure(model: Thumbnail, radius: CGFloat){
        self.adImg.image = model.img
        self.adImg.layer.cornerRadius = radius
    }
}
