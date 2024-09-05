//
//  AnAnVideoDetailViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/16.
//

import UIKit
import SnapKit


class AnAnVideoDetailViewController: AnAnBaseViewController {

    var isPlayer:Bool = true
    var dramaId:String = ""
    var episodeSid:String = ""
    var quality:String = "SD"
    var isRecByUser:Int = 0
    var subtitle:Int = 0
    
    private var videoDetailModel:AnAnDetailModel?
    
    private lazy var playerViewController:AnAnVideoPlayerViewController = {
        let viewController = AnAnVideoPlayerViewController()
        return viewController
    }()
    
//
    private lazy var headerView:AnAnHeaderView = {
        let view = AnAnHeaderView()
        return view
    }()
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    fileprivate lazy var sengmentCollectionView:AnAnSengmentTitleCollectionView = {
        let collectionView = AnAnSengmentTitleCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.selectIndexBlock = {[weak self] index in
            
            if let oldIndex = self?.oldScrollIndex, oldIndex > index {
                self?.pageController.setViewControllers([self?.controllersArray[index] ?? UIViewController()], direction: .reverse, animated: true)
            }else{
                self?.pageController.setViewControllers([self?.controllersArray[index] ?? UIViewController()], direction: .forward, animated: true)
            }
            self?.oldScrollIndex = index
        }
        return collectionView
    }()
    
//    详情
    private lazy var detailController:AnAnDetailViewController = {
        let controller = AnAnDetailViewController()
        return controller
    }()
//    讨论
    private lazy var commentController:AnAnCommentViewController = {
        let controller = AnAnCommentViewController()
        return controller
    }()
//    影评
    private lazy var filmReviewController:AnAnFilmReviewViewController = {
        let controller = AnAnFilmReviewViewController()
        return controller
    }()
    
//    下载选集视图
    private lazy var downloadPopView:AnAnDownloadEpisodePopView = {
        let view = AnAnDownloadEpisodePopView()
        view.selectBtnBlock = {[weak self] btn in
            switch btn.tag {
            case 100:
                self?.removeDownloadPopView()
                break
            case 200:
      
                break
            case 300:
               
                break
            case 400:
                AnAnJumpPageManager.goToDownloadPage(isLookDownloading: true)
                break
            default:
                break
            }
        }
        return view
    }()
    
    
    fileprivate lazy var controllersArray:[UIViewController] = {
        let array = [detailController,commentController,filmReviewController]
        return array
    }()
//    当前滑动的位置
    fileprivate var currentScrollIndex:Int = 0
//    上次滑动的位置
    fileprivate var oldScrollIndex:Int = 0
    
    private lazy var pageController:UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,options: [UIPageViewController.OptionsKey.spineLocation:0,UIPageViewController.OptionsKey.interPageSpacing:0])
//        设置初始界面
        pageController.setViewControllers([detailController], direction: .forward, animated: true)
        pageController.delegate = self
        pageController.dataSource = self
        return pageController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        setSubviewsFrame()
        if isPlayer {
            arrowBackBtn.isHidden = true
        }else{
            view.bringSubviewToFront(arrowBackBtn)
        }
//        添加
        self.addChild(pageController)
        NotificationCenter.default.addObserver(self, selector: #selector(swichEpisodeNotifi), name: AnAnNotifacationName.SwitchEpisode, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popDownloadSelectEpisodeView), name: AnAnNotifacationName.PopDownloadView, object: nil)
//        请求网路数据
        requestDramaDetailData()
        requestDramaIntroData()
        requestDramaModuleData()
        requestDramaSecondaryData()
        requestDramaRecommendData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        headerView.layoutIfNeeded()
//        headerView.insertGradientColor(cornerRadius: 0, colors: [UIColor.hexadecimalColor(hexadecimal: An_1F2126).cgColor,UIColor.hexadecimalColor(hexadecimal: An_1F2126,alpha: 0.5).cgColor])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let orientation = UIApplication.shared.statusBarOrientation
        switch orientation {
        case .portrait,.portraitUpsideDown,.unknown:  /// 竖屏
            playerViewController.view.snp.remakeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.height.equalTo(210 + max(AnAnAppDevice.deviceTop(), AnAnAppDevice.deviceLeft) )
            }
            break
        case .landscapeLeft,.landscapeRight: ///横屏
            playerViewController.view.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            break
        default:
            break
        }
    }
    
    private func createSubviews() {
        if isPlayer {
            self.addChild(playerViewController)
            view.willRemoveSubview(playerViewController.view)
            view.addSubview(playerViewController.view)
            view.didAddSubview(playerViewController.view)
        }else{
            view.addSubview(headerView)
        }
        view.addSubview(sengmentCollectionView)
        view.addSubview(pageController.view)
        view.addSubview(downloadPopView)
    }
    
    private func setSubviewsFrame() {
        var top:ConstraintItem
        if isPlayer {
            playerViewController.view.snp.makeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.height.equalTo(210 + AnAnAppDevice.deviceTop())
            }
            top = playerViewController.view.snp.bottom
        }else{
            headerView.snp.makeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.height.equalTo(255+AnAnAppDevice.deviceTop())
            }
            top = headerView.snp.bottom
        }
        sengmentCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(top)
            make.trailing.equalTo(-146)
            make.height.equalTo(46.5)
        }
        pageController.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(sengmentCollectionView.snp.bottom)
            make.bottom.equalTo(-AnAnAppDevice.deviceBottom)
        }
        downloadPopView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(AnAnAppDevice.an_screenHeight())
        }
    }
    
//    添加
    private func addDownloadPopView(){
        downloadPopView.removeFromSuperview()
        view.addSubview(downloadPopView)
        downloadPopView.episodeList = videoDetailModel?.episodeList
        downloadPopView.dramaId = dramaId
        downloadPopView.dramaInfo = videoDetailModel?.dramaInfo
        downloadPopView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(AnAnAppDevice.an_screenHeight()-playerViewController.view.frame.height)
            make.top.equalTo(playerViewController.view.snp.bottom)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
//    移除
    private func removeDownloadPopView(){
        downloadPopView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(AnAnAppDevice.an_screenHeight()-playerViewController.view.frame.height)
            make.top.equalTo(AnAnAppDevice.an_screenHeight())
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }completion: {[weak self] _ in
            self?.downloadPopView.removeFromSuperview()
        }
    }
//
    @objc private func swichEpisodeNotifi(noti:Notification){
        let model:EpisodeListModel = noti.userInfo?["episodeModel"] as? EpisodeListModel ?? EpisodeListModel()
        playerViewController.sid = model.sid
        playerViewController.currentPlayerEpisode = (Int(model.episodeNo ?? "") ?? 0) - 1
        playerViewController.requestDetailPlayerInfoData()
    }
    
    @objc private func popDownloadSelectEpisodeView(noti:Notification){
        addDownloadPopView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("视频详情视图销毁")
    }
}


extension AnAnVideoDetailViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource {

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
            sengmentCollectionView.selectIndex = currentScrollIndex
            oldScrollIndex = currentScrollIndex
        }
    }
    
}

// 获取网络数据
extension AnAnVideoDetailViewController{
//    请求详情数据
    fileprivate func requestDramaDetailData(){
        AnAnRequest.shared.requestDramaDetailData(dramaId: dramaId, episodeSid: episodeSid, quality: quality, isRecByUser: isRecByUser, subtitle: subtitle) {[weak self] model in
            guard let `self` else { return }
            
            AnAnPlayerUrlParse.playerUrlParse(url: model?.watchInfo?.m3u8?.url ?? "") {[weak self] parseUrl in
                self?.playerViewController.playerUrl = parseUrl
            }
            self.detailController.videoDetailModel = model
            self.playerViewController.videoDetail = model
            self.playerViewController.dramaId = self.dramaId
            self.playerViewController.episodeList = model?.episodeList
            self.videoDetailModel = model
        }
    }
//    请求专辑信息数据
    fileprivate func requestDramaIntroData(){
        AnAnRequest.shared.requestDramaDetailIntroData(dramaId: dramaId) {[weak self] model in
            guard let `self` else { return }
            self.detailController.dramaIntroModel = model
        }
    }
    
//    请求演员，和专辑列表数据
    fileprivate func requestDramaModuleData(){
        AnAnRequest.shared.requestDramaDetailModule(dramaId: dramaId) {[weak self] model in
            guard let `self` else { return }
            self.detailController.dramaModuleModel = model
        }
    }
    fileprivate func requestDramaSecondaryData(){
        AnAnRequest.shared.requestDramaDetailSecondaryData(dramaId: dramaId) {[weak self] model in
            guard let `self` else { return }
            self.detailController.seconDarayModel = model
        }
    }
    
    fileprivate func requestDramaRecommendData(){
        AnAnRequest.shared.requestDramaRecommendData(dramaId: dramaId, isRecByUser: isRecByUser) {[weak self] model in
            guard let `self` else { return }
            self.detailController.recommendModel = model
        }
    }
}
