//
//  MainItem.swift
//  Armagetdon
//
//  Created by 김나연 on 7/4/24.
//

import Foundation
import UIKit

struct Thumbnail{
    var img: UIImage?
}
struct MainPost{
    var img: UIImage?
    var title: String
    var nickname: String
    var rankimage: UIImage?
    var recommendCount: Int
}
final class MainItem{
    static let thumbnailDataList: [Thumbnail] = [
        Thumbnail(img: UIImage(named: "Image1")),
        Thumbnail(img: UIImage(named: "Image2")),
        Thumbnail(img: UIImage(named: "Image3")),
        Thumbnail(img: UIImage(named: "Image4")),
        Thumbnail(img: UIImage(named: "Image5"))
    ]
    static let mainpostDataList: [MainPost] = [
            MainPost(img: UIImage(named: "utube1"), title: "히사이시 조의 비 오는 여름 작업실ㅣ🎥 𝟰𝗸 𝐩𝐥𝐚𝐲𝐥𝐢𝐬𝐭", nickname: "현란한 귤", rankimage: UIImage(named: "badge01"), recommendCount: 3),
            MainPost(img: UIImage(named: "utube2"), title: "'발바닥 기술'도 장착…'업그레이드' 코리안가이 / SBS 8뉴스", nickname: "무서운 토마토", rankimage: UIImage(named: "badge02"), recommendCount: 5),
            MainPost(img: UIImage(named: "utube3"), title: "NewJeans (뉴진스) ‘Supernatural’ Official MV (Part.2)", nickname: "멋진 젤리", rankimage: UIImage(named: "badge02"), recommendCount: 3),
            MainPost(img: UIImage(named: "utube4"), title: "【3D 입체음향】 🏰✨디즈니&픽사 OST 모음 | 𝘋𝘪𝘴𝘯𝘦𝘺 𝘖𝘚𝘛 | 전곡 가사", nickname: "가는 젤리", rankimage: UIImage(named: "badge05"), recommendCount: 9),
            MainPost(img: UIImage(named: "utube5"), title: "𝐏𝐥𝐚𝐲𝐥𝐢𝐬𝐭 어른이 된다는게 이런건가봐🔮, 픽사 재즈", nickname: "안타까운 장군", rankimage: UIImage(named: "badge03"), recommendCount: 3)
        ]}
