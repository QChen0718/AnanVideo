//
//  AnAnSearchResultViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

enum SearchResultType {
    case season
    case actor
    case sheet
    case video
}

class AnAnSearchResultViewController: AnAnBaseViewController {

    fileprivate lazy var searchView:SearchView = {
      let view = SearchView()
        return view
    }()
    
    private lazy var synthesisController:AnAnSearchSynthesisViewController = {
       let controll = AnAnSearchSynthesisViewController()
        return controll
    }()
    
    private lazy var dramaController:AnAnSearchDramaViewController = {
       let controll = AnAnSearchDramaViewController()
        return controll
    }()
    
    private lazy var pdController:AnAnSearchPDViewController = {
       let controll = AnAnSearchPDViewController()
        return controll
    }()
    
    private lazy var shortvideoController:AnAnSearchShortVideoViewController = {
       let controll = AnAnSearchShortVideoViewController()
        return controll
    }()
    
    private lazy var actorController:AnAnSearchActorViewController = {
       let controll = AnAnSearchActorViewController()
        return controll
    }()
    
    fileprivate lazy var controllersArray:[UIViewController] = {
        let array = [synthesisController,dramaController,pdController,shortvideoController,actorController]
        return array
    }()
    
//    当前滑动的位置
    fileprivate var currentScrollIndex:Int = 0
//    上次滑动的位置
    fileprivate var oldScrollIndex:Int = 0
    
    lazy var zhModel:AnAnHotModel = {
       let m = AnAnHotModel()
        m.hotRecommend = "综合"
        m.isSelect = true
        return m
    }()
    lazy var videoModel:AnAnHotModel = {
       let m = AnAnHotModel()
        m.hotRecommend = "影视"
        m.isSelect = false
        return m
    }()
    lazy var pdModel:AnAnHotModel = {
       let m = AnAnHotModel()
        m.hotRecommend = "片单"
        m.isSelect = false
        return m
    }()
    lazy var quikModel:AnAnHotModel = {
       let m = AnAnHotModel()
        m.hotRecommend = "快看"
        m.isSelect = false
        return m
    }()
    lazy var actorModel:AnAnHotModel = {
       let m = AnAnHotModel()
        m.hotRecommend = "明星"
        m.isSelect = false
        return m
    }()
    
    private var pageTitleArray:[AnAnHotModel?] = []
    
    
    var searchKey:String?{
        didSet{
            searchView.searchTextField.text = searchKey
            synthesisController.searchKey = searchKey
            pdController.searchKey = searchKey
            dramaController.searchKey = searchKey
            shortvideoController.searchKey = searchKey
            actorController.searchKey = searchKey
        }
    }
    
    lazy var cancelBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_222222), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var pagetitleCollection:AnAnPageTitleCollectionview = {
        let view = AnAnPageTitleCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var resultPagecontrol:UIPageViewController = {
        let control = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.spineLocation:0,UIPageViewController.OptionsKey.interPageSpacing:0])
        control.setViewControllers([synthesisController], direction: .forward, animated: true)
        control.delegate = self
        control.dataSource = self
        return control
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitleArray.append(zhModel)
        pageTitleArray.append(videoModel)
        pageTitleArray.append(pdModel)
        pageTitleArray.append(quikModel)
        pageTitleArray.append(actorModel)
        self.addChild(resultPagecontrol)
        view.backgroundColor = .white
        view.addSubview(searchView)
        view.addSubview(cancelBtn)
        view.addSubview(pagetitleCollection)
        view.addSubview(resultPagecontrol.view)
        
        pagetitleCollection.dataList = pageTitleArray
        
        searchView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(cancelBtn.snp.leading).offset(-20)
            make.top.equalTo(AnAnAppDevice.deviceTop()+6)
            make.height.equalTo(36)
        }
        cancelBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(searchView)
            make.size.equalTo(CGSize(width: 40, height: 21))
        }
        pagetitleCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(6)
            make.height.equalTo(40)
        }
        resultPagecontrol.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(AnAnAppDevice.deviceBottom)
            make.top.equalTo(pagetitleCollection.snp.bottom).offset(10)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableDataList), name: NSNotification.Name("updateSearchTable"), object: nil)
        
    }

    @objc func cancelBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshTableDataList(noti:Notification){
        let dict = noti.userInfo
        guard let index = dict?["selectIndex"] as? Int else { return }
        pagetitleCollection.curIndex = index
        if self.oldScrollIndex > index {
            self.resultPagecontrol.setViewControllers([self.controllersArray[index]], direction: .reverse, animated: true)
        }else{
            self.resultPagecontrol.setViewControllers([self.controllersArray[index] ], direction: .forward, animated: true)
        }
        self.oldScrollIndex = index
    }
}


extension AnAnSearchResultViewController{
    
}

extension AnAnSearchResultViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
//    上个界面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index:Int = controllersArray.firstIndex(of: viewController) ?? 0
//        第一页
        if index == 0 || index == NSNotFound{
            return nil
        }
        index-=1
        return controllersArray[index]
    }
//    下个界面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index:Int = controllersArray.firstIndex(of: viewController) ?? 0
//        第一页
        if index == controllersArray.count-1 || index == NSNotFound{
            return nil
        }
        index+=1
        return controllersArray[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let index:Int = controllersArray.firstIndex(of: pendingViewControllers.first ?? UIViewController()) ?? 0
        currentScrollIndex = index
        print("index----->\(currentScrollIndex)")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed){
            pagetitleCollection.curIndex = currentScrollIndex
            oldScrollIndex = currentScrollIndex
        }
    }
}

fileprivate class SearchView: UIView {
    
    lazy var searchTextField:UITextField = {
       let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "大家都在搜“扶摇”", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_CACBCC),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
        textfield.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        textfield.font = .systemFont(ofSize: 15, weight: .regular)
        return textfield
    }()
    
    lazy var closeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_00A3FF,alpha: 0.1)
        self.layer.cornerRadius = 18
        
        addSubview(searchTextField)

        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func closeBtnClick(){
        
    }
}
