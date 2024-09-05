//
//  AnAnDownloadViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnDownloadViewController: AnAnBaseViewController {

    var isLookDownloading:Bool = false
    
//    当前滑动的位置
    fileprivate var currentScrollIndex:Int = 0
    
//    上次滑动的位置
    fileprivate var oldScrollIndex:Int = 0
    
    private lazy var centerTitleBgView:UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var successBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"已完成",font: UIFont.pingFangRegularWithSize(fontSize: 17),fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F),target: self, action: #selector(btnClick))
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), for: .selected)
        btn.tag = 100
        return btn
    }()
    
    private lazy var loadingBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"下载中",font: UIFont.pingFangRegularWithSize(fontSize: 17),fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F),target: self, action: #selector(btnClick))
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), for: .selected)
        btn.tag = 200
        return btn
    }()
    
    private lazy var managerBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"管理",font: UIFont.pingFangRegularWithSize(fontSize: 15),fontColor: UIColor.hexadecimalColor(hexadecimal: An_DADAE0),target: self, action: #selector(btnClick))
        btn.tag = 300
        return btn
    }()
//    已完成
    private lazy var downloadSuccessVC:AnAnDownloadSuccessViewController = {
        let vc = AnAnDownloadSuccessViewController()
        return vc
    }()
//    下载中
    private lazy var downloadLoadingVC:AnAnDownloadLoadingViewController = {
        let vc = AnAnDownloadLoadingViewController()
        return vc
    }()
    
    private lazy var controllersAry:[UIViewController] = {
        let array = [downloadSuccessVC,downloadLoadingVC]
        return array
    }()
    
    private lazy var pageController:UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,options: [UIPageViewController.OptionsKey.spineLocation:0,UIPageViewController.OptionsKey.interPageSpacing:0])
//        设置初始界面
        
        pageController.delegate = self
        pageController.dataSource = self
        return pageController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_16161C)
        addChild(pageController)
        if isLookDownloading {
            pageController.setViewControllers([downloadLoadingVC], direction: .forward, animated: true)
            loadingBtn.isSelected = true
            loadingBtn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
        }else{
            pageController.setViewControllers([downloadSuccessVC], direction: .reverse, animated: true)
            successBtn.isSelected = true
            successBtn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
        }
        createSubviews()
        setSubviewsFrame()
    }
    
    private func createSubviews() {
        view.addSubview(centerTitleBgView)
        centerTitleBgView.addSubview(successBtn)
        centerTitleBgView.addSubview(loadingBtn)
        view.addSubview(managerBtn)
        view.addSubview(pageController.view)
    }
    
    private func setSubviewsFrame() {
        centerTitleBgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(AnAnAppDevice.deviceTop())
            make.size.equalTo(CGSize(width: 126, height: 43))
        }
        successBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
            make.width.equalTo(51)
        }
        loadingBtn.snp.makeConstraints { make in
            make.leading.equalTo(successBtn.snp.trailing).offset(24)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(successBtn)
        }
        managerBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalTo(centerTitleBgView)
            make.size.equalTo(CGSize(width: 30, height: 14))
        }
        pageController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(centerTitleBgView.snp.bottom)
        }
    }
    
    
    @objc private func btnClick(btn:UIButton){
        if btn.tag == 100 {
            successBtn.isSelected = true
            successBtn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
            loadingBtn.isSelected = false
            loadingBtn.titleLabel?.font = UIFont.pingFangRegularWithSize(fontSize: 17)
        }else {
            loadingBtn.isSelected = true
            loadingBtn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
            successBtn.isSelected = false
            successBtn.titleLabel?.font = UIFont.pingFangRegularWithSize(fontSize: 17)
        }
    }
    
}


extension AnAnDownloadViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
//    上个界面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index:Int = controllersAry.firstIndex(of: viewController) ?? 0
//        第一页
        if index == 0 || index == NSNotFound{
            return nil
        }
        index-=1
        return controllersAry[index]
    }
//    下个界面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index:Int = controllersAry.firstIndex(of: viewController) ?? 0
//        第一页
        if index == controllersAry.count-1 || index == NSNotFound{
            return nil
        }
        index+=1
        return controllersAry[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let index:Int = controllersAry.firstIndex(of: pendingViewControllers.first ?? UIViewController()) ?? 0
        currentScrollIndex = index
        print("index----->\(currentScrollIndex)")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed){
            if(controllersAry[currentScrollIndex].isKind(of: AnAnDownloadSuccessViewController.self)){
                successBtn.isSelected = true
                successBtn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
                loadingBtn.isSelected = false
                loadingBtn.titleLabel?.font = UIFont.pingFangRegularWithSize(fontSize: 17)
            }else{
                loadingBtn.isSelected = true
                loadingBtn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
                successBtn.isSelected = false
                successBtn.titleLabel?.font = UIFont.pingFangRegularWithSize(fontSize: 17)
            }
            oldScrollIndex = currentScrollIndex
        }
    }
}
