//
//  Tabbar.swift
//  Armagetdon
//
//  Created by 김나연 on 7/4/24.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        appearance()
    }
    private func setTabBar(){
        let vc1 = UINavigationController(rootViewController: MainViewController())
        vc1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 1)
        let vc2 = RankingViewController()
        vc2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "trophy.fill"), tag: 2)
        let vc3 = MyViewController()
        vc3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle.fill"), tag: 3)
        self.viewControllers = [vc1,vc2,vc3]
    }
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .white
    }
}
