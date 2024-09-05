//
//  AnAnTabBarViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit

class AnAnTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        // Do any additional setup after loading the view.
        let home = setTabbarItem(title: "推荐", imageName: "ic_tabbar_home_n", selectImageName: "ic_tabbar_home_h",vc: AnAnHomeViewController())
        let fastVideo = setTabbarItem(title: "快视频", imageName: "arrowtriangle.right.circle", selectImageName: "arrowtriangle.right.circle.fill", vc: AnAnShortVideoViewController())
        let category = setTabbarItem(title: "分类", imageName: "ic_tabbar_fenlei_n", selectImageName: "ic_tabbar_fenlei_h",vc: AnAnCategoryViewController())
        let me = setTabbarItem(title: "我的", imageName: "ic_tabbar_me_n", selectImageName: "ic_tabbar_me_h",vc: AnAnMeViewController())
        self.viewControllers = [home,fastVideo,category,me];
    }
    
    func setTabbarItem(title:String?,imageName:String?,selectImageName:String?,vc:UIViewController) -> AnAnNavigationViewController {
        let nav = AnAnNavigationViewController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: imageName ?? "");
        nav.tabBarItem.selectedImage = UIImage(named: selectImageName ?? "")
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_454753)], for: .normal)
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_1890FF)], for: .selected)
        return nav
    }
}
