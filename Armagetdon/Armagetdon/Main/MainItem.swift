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
        MainPost(img: UIImage(named: "Image1"), title: "동영상1", nickname: "인간1", rankimage: UIImage(named: "heart red"), recommendCount: 11),
        MainPost(img: UIImage(named: "Image1"), title: "동영상2", nickname: "인간2", rankimage: UIImage(named: "heart red"), recommendCount: 10),
        MainPost(img: UIImage(named: "Image1"), title: "동영상3", nickname: "인간3", rankimage: UIImage(named: "heart red"), recommendCount: 9),
        MainPost(img: UIImage(named: "Image1"), title: "동영상4", nickname: "인간4", rankimage: UIImage(named: "heart red"), recommendCount: 22),
        MainPost(img: UIImage(named: "Image1"), title: "동영상5", nickname: "인간5", rankimage: UIImage(named: "heart red"), recommendCount: 1)
    ]
}
