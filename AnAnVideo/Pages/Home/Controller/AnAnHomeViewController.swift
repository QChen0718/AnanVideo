//
//  AnAnHomeViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

//首页组件模块
/*
 VIDEO              影视组件（支持平铺与横滑）
 VIDEO_AUTO         影视数据自动（支持平铺与横滑）
 MAGIC_CUBE         魔方组件（支持平铺）
 SHEET              片单组件（支持平铺与横滑）
 TOP                榜单组件（支持横滑）
 SINGLE_IMAGE       单图组件（支持平铺）
 MULTI_IMAGE        多图组件（支持平铺与横滑）
 SHORT_VIDEO        短视频组件 (支持平铺)
 BEAN               小豆干 （仅首页，和banner一起展示）
 AD                 广告      仅平铺
*/

import UIKit
import SnapKit


class AnAnHomeViewController: AnAnBaseViewController {

    private var vcs:[UIViewController] = [AnAnRecommendViewController(),AnAnVipViewController()]
    
    private var currentIndex:Int = 0
    
    lazy var pageControllers:UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.setViewControllers([vcs[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        vc.didMove(toParent: self)
        return vc
    }()
    
    lazy var headerImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_houme_tuijian_bg"))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    lazy var recommendBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("推荐", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_222222), for: .selected)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_6877AE), for: .normal)
        btn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 24)
        btn.tag = 100
        btn.isSelected = true
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    lazy var vipBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("VIP", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_222222), for: .selected)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_6877AE), for: .normal)
        btn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 24)
        btn.tag = 200
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var searchBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("《9号秘事》热播中", for: .normal)
        btn.setImage(UIImage(named: "ic_home_tuijian_search"), for: .normal)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF_50,alpha:0.5)
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_6877AE), for: .normal)
        btn.titleLabel?.font = UIFont.pingFangRegularWithSize(fontSize: 12)
        btn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var cornerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cornerView.layoutIfNeeded()
        cornerView.setConerTop(radius: 17)
    }
    var array:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addChild(pageControllers)
        createSubviews()
        setSubviewsFrame()
    }
    
    @objc func searchBtnClick(){
        AnAnJumpPageManager.goToSearchPage()
    }

    func createSubviews() {
        view.addSubview(headerImageView)
        headerImageView.addSubview(recommendBtn)
        headerImageView.addSubview(vipBtn)
        headerImageView.addSubview(searchBtn)
        headerImageView.addSubview(cornerView)
        view.addSubview(pageControllers.view)
    }
    func setSubviewsFrame() {
        headerImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        recommendBtn.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(AnAnAppDevice.deviceTop())
            make.size.equalTo(CGSize(width: 50, height: 29))
        }
        
        vipBtn.snp.makeConstraints { make in
            make.leading.equalTo(self.recommendBtn.snp.trailing).offset(20)
            make.centerY.size.equalTo(self.recommendBtn)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalTo(self.recommendBtn)
            make.size.equalTo(CGSize(width: 160, height: 40))
        }
        cornerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
        pageControllers.view.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(self.headerImageView.snp.bottom)
        }
    }
    
    
    @objc func btnClick(btn:UIButton) {
        if btn.tag == 100 {
            recommendBtn.isSelected = true
            vipBtn.isSelected = false
            headerImageView.image = UIImage(named: "img_houme_tuijian_bg")
            pageControllers.setViewControllers([vcs[0]], direction: .reverse, animated: true)
        }else {
            recommendBtn.isSelected = false
            vipBtn.isSelected = true
            headerImageView.image = UIImage(named: "img_houme_vip_bg")
            pageControllers.setViewControllers([vcs[1]], direction: .forward, animated: true)
        }
    }

}

extension AnAnHomeViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
//    将要滑动切换
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let nextVC = pendingViewControllers.first ?? UIViewController()
        let index:Int = vcs.firstIndex(of: nextVC) ?? 0
//        获取到要滑动的控制器下标
        currentIndex = index
    }
//    滑动结束
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed){
            if(vcs[currentIndex].isKind(of: AnAnVipViewController.self)){
                recommendBtn.isSelected = false
                vipBtn.isSelected = true
                headerImageView.image = UIImage(named: "img_houme_vip_bg")
            }else{
                recommendBtn.isSelected = true
                vipBtn.isSelected = false
                headerImageView.image = UIImage(named: "img_houme_tuijian_bg")
            }
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        向前滑动
        var index:Int = vcs.firstIndex(of: viewController) ?? 0
        if index == 0 || index == NSNotFound {
            return nil;
        }else{
            index-=1
            return vcs[index];
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        向后滑动
        var index:Int = vcs.firstIndex(of: viewController) ?? 0
        if index == vcs.count - 1 || index == NSNotFound{
            return nil;
        }else{
            index+=1
            return vcs[index];
        }
        
    }
}
