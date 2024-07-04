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
        vc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 1)
        let vc2 = RankingViewController()
        vc2.tabBarItem = UITabBarItem(title: "랭킹", image: UIImage(named: "rank"), tag: 2)
        let vc3 = UINavigationController(rootViewController: MyViewController())
        vc3.tabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "my"), tag: 3)
        self.viewControllers = [vc1,vc2,vc3]
    }
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "Mblack")
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .white
    }
    class CustomHeightTabBar: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)

        guard let window = UIApplication.shared.connectedScenes
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter( { $0.isKeyWindow } ).first
        else { return sizeThatFits }
        let tabBarHeight: CGFloat = 60
        sizeThatFits.height = tabBarHeight + window.safeAreaInsets.bottom
        return sizeThatFits
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomHeightTabBar.self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
