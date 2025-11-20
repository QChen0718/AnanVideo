//
//  AnAnVideoPlayerViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//  懒加载中不能将当前对象，或者本身给到其他子类，不然会引起循环引用

import UIKit
import NetSpeed
import MediaPlayer

// 设置滑动方向枚举
enum SlidingDirection:Int {
    case SlidingDirectionLeftOrRight
    case SlidingDirectionUpOrDown
    case SlidingDirectionNone
}

class AnAnVideoPlayerViewController: UIViewController {
    
//    滑动进度条
    var playerUrl:String?{
        didSet {
            guard let url = playerUrl, !url.isEmpty else {
                return
            }
            initPlayerManagerView()
        }
    }
    
    var videoDetail:AnAnDetailModel?{
        didSet{
            selectQualityView.qualityArray = videoDetail?.watchInfo?.sortedItems
            topView.movieName = String(format: "%@ 第%d集", videoDetail?.dramaInfo?.title ?? "",currentPlayerEpisode+1)
            sid = videoDetail?.watchInfo?.m3u8?.episodeSid
            barragePlayView.videoDetail = videoDetail
        }
    }
    
    var dramaId:String?
    
    var episodeList:[EpisodeListModel]?{
        didSet{
            if let count = episodeList?.count, currentPlayerEpisode == count-1 {
                bottomView.isHiddenNextBtn = true
            }else{
                bottomView.isHiddenNextBtn = false
            }
            selectEpisodeView.episodeListArray = episodeList
        }
    }
    
    var currentPlayerEpisode:Int = 0 {
        didSet{
            selectEpisodeView.currentPlayerIndex = currentPlayerEpisode
            if let count = episodeList? .count, currentPlayerEpisode == count-1 {
                bottomView.isHiddenNextBtn = true
            }else{
                bottomView.isHiddenNextBtn = false
            }
        }
    }
    
    var sid:String?
    private var episodeNo:String?
    private var quality:String?
    
    //滑动方向
    private var slidingDirection:SlidingDirection?
    //是否是音量滑动
    private var isVolume:Bool?
//  当前屏幕亮度
    private var currentScrrenBrightness:CGFloat?
//  当前手机音量
    private var currentVolume:Float?
//  开始亮度滑动位置
    private var oldBrightnessLocation:CGFloat?
//  开始音量滑动位置
    private var oldVolumeLocation:CGFloat?
//  上次水平滑动的位置，来调整滑动进度
    private var oldHorizontalLocation:CGFloat? = 0
//  底部操作视图高度
    private var bottomHeight:CGFloat = 45
    
    private lazy var bottomView:AnAnPlayerBottomView = {
        let view = AnAnPlayerBottomView()
        view.closeTimeBlock = {[weak self] isCancel in
            if isCancel {
                self?.hiddenViewTimerCount = 5
                self?.cancelTimer()
            }else{
                self?.initTimer()
            }
        }
        view.selectBtnBlock = {[weak self] btn in
            guard let `self` else {return}
            if btn.tag == 100 {
//                播放下一集
                self.nextPlayerVideo()
            }else if btn.tag == 200 {
//                全屏播放
                AnAnScreenTool.shared.switchScreenOrientation(vc: self, mode: .set_land,deviceOrientation:.landscapeLeft)
            }else if btn.tag == 300 {
//                弹幕开关状态
                if btn.isSelected {
                    addBarragePlayView()
                }else{
                    removeBarragePlayView()
                }
            }else if btn.tag == 400 {
//                弹幕设置
                addBarrageSetView()
            }else if btn.tag == 500 {
//                发送弹幕
                addBarrageInputView()
            }
            else if btn.tag == 600 {
                self.addEpisodeView()
            }else if btn.tag == 700 {
                self.addSpeedView()
            }else if btn.tag == 800 {
                self.addQualityView()
            }
            
        }
        return view
    }()
    
    private lazy var loadingView:AnAnPlayerLoadingView = {
        let view = AnAnPlayerLoadingView()
        return view
    }()
    
    private lazy var topView:AnAnPlayerTopView = {
        let view = AnAnPlayerTopView()
        view.selectBtnBlock = {[weak self] btn in
            guard let `self` = self else { return }
            if btn.tag == 100 {
                if self.currentOrientation == .set_land{
                    //            横屏
                    AnAnScreenTool.shared.switchScreenOrientation(vc: self, mode: .set_port)
        
                }else{
                    //            竖屏
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
        return view
    }()
    
    private var playerManagerView:AnAnVideoPlayerManager?
//    隐藏操作栏定时器
    private var viewHiddenTimer:Timer?
    var hiddenViewTimerCount:Int = 3
    
    private lazy var selectEpisodeView:AnAnSelectEpisodeView = {
        let view = AnAnSelectEpisodeView()
        view.reportEpisodeBlock = {[weak self] model,index in
            self?.sid = model?.sid
            self?.episodeNo = model?.episodeNo
            self?.currentPlayerEpisode = index
//            请求剧集播放地址
            self?.requestDetailPlayerInfoData()
            self?.removeVideoOperitionView()
        }
        return view
    }()
    
    private lazy var selectQualityView:AnAnSelectQualityView = {
        let view = AnAnSelectQualityView()
        view.currentQualityBlock = {[weak self] model in
            self?.quality = model?.qualityCode
//            请求剧集播放地址
            self?.topView.currentQuality = model?.qualityDescription ?? ""
//            保存播放信息
//            self?.saveLookHistoryData()
            self?.requestDetailPlayerInfoData()
            self?.removeVideoOperitionView()
        }
        return view
    }()
    
    private lazy var selectSpeedView:AnAnSelectSpeedView = {
       let view = AnAnSelectSpeedView()
        view.currentSpeedBlock = {[weak self] value in
            guard let `self` else {return}
            self.playerManagerView?.playerRate = value
            self.removeVideoOperitionView()
        }
        return view
    }()
    
    private lazy var barrageView:AnAnBarrageSetView = {
       let view = AnAnBarrageSetView()
        return view
    }()
    
    private lazy var barrageInputView:AnAnBarrageInputView = {
       let view = AnAnBarrageInputView()
        view.sendBarrageBlock = { [weak self] content in
            print("barrageContent--->\(content)")
        }
        view.closeBarrageBlock = { [weak self] in
            guard let `self` else { return }
            self.removeBarrageInputView()
        }
        return view
    }()
    
//    弹幕展示视图
    lazy var barragePlayView:AnAnBarrageView = {
       let view = AnAnBarrageView()
        view.playerManagerView = playerManagerView
        return view
    }()
    
//    滑动提示播放进度块
    private lazy var dragPlayerTimeView:AnAnDragPlayerTimeView = {
        let view = AnAnDragPlayerTimeView()
        return view
    }()
    
//    长按提示播放速度视图
    private lazy var longSpeedView:AnAnLongSpeedView = {
        let view = AnAnLongSpeedView()
        return view
    }()
    
//    音量调节提示视图
    private lazy var volumeView:AnAnVolumeView = {
       let view = AnAnVolumeView()
        return view
    }()
//    亮度调节提示视图
    lazy var brightnessView:AnAnluminanceView = {
       let view = AnAnluminanceView()
        return view
    }()
//    点击手势
    private lazy var tapGesture:UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        tap.delegate = self
        return tap
    }()
    
//    双击手势
    private lazy var doubleTapGesture:UITapGestureRecognizer = {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapClick))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        return doubleTap
    }()
    
//    添加拖拽手势
    private lazy var panGesture:UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panDirection))
        pan.delegate = self
        return pan
    }()
    
//    添加长按手势
    private lazy var longGesture:UILongPressGestureRecognizer = {
        let long = UILongPressGestureRecognizer(target: self, action: #selector(longDirection))
        long.delegate = self
        return long
    }()
    
    
    
    var currentOrientation:SCREEN_SET = .set_auto
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(doubleTapGesture)
        view.addGestureRecognizer(panGesture)
        view.addGestureRecognizer(longGesture)
//        设备方向通知
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
//        监听
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
//        测网速 NetSpeed
        NetSpeed.shared.delegate = self
        NetSpeed.shared.begin()
        
        createSubviews()
        setSubviewsFrame()
        initTimer()
        currentScrrenBrightness = getCurrentScreenBrightness()
        currentVolume = getSystemVolumValue()
    }
    
    private func createSubviews() {
        view.addSubview(topView)
       
        view.addSubview(loadingView)
        view.addSubview(bottomView)
    }
    
    private func setSubviewsFrame() {
        topView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(38)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(bottomHeight)
            make.bottom.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 96))
        }
    }
    
// 切换很竖屏时，重设子view布局
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        判断横竖屏切换
        topView.snp.updateConstraints { make in
            make.top.equalToSuperview()
        }
        let isLandscape: Bool
        if #available(iOS 13.0, *) {
            isLandscape = size.width > size.height
        } else {
            // Fallback on earlier versions
            let orientation = UIApplication.shared.statusBarOrientation
            isLandscape = orientation.isLandscape
        }
        if isLandscape {
            currentOrientation = .set_land
            bottomHeight = 84
        }else{
            currentOrientation = .set_port
            bottomHeight = 45
        }
        bottomView.snp.updateConstraints { make in
            make.height.equalTo(bottomHeight)
        }
        topView.orientationUpdateViews(isLandscape: isLandscape)
        bottomView.orientationUpdateViews(isLandscape: isLandscape)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnAnScreenTool.shared.switchScreenOrientation(vc: self, mode: .set_auto)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AnAnScreenTool.shared.switchScreenOrientation(vc: self, mode: .set_port)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // 根据 currentOrientation 控制
        switch currentOrientation {
        case .set_land:
            return .landscape
        case .set_port:
            return .portrait
        case .set_auto:
            return .allButUpsideDown
        }
    }
    
    
//    添加或移除操作视图
    private func addEpisodeView(){
//        防止多次点击触发多次添加
        animationHiddenVideoOperationView()
        selectEpisodeView.removeFromSuperview()
        view.addSubview(selectEpisodeView)
        selectEpisodeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectEpisodeView.showSelectEpView()
    }
    
    private func addQualityView(){
        animationHiddenVideoOperationView()
        selectQualityView.removeFromSuperview()
        view.addSubview(selectQualityView)
        selectQualityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectQualityView.showSelectQualityView()
    }
    
    private func addSpeedView(){
        animationHiddenVideoOperationView()
        selectSpeedView.removeFromSuperview()
        view.addSubview(selectSpeedView)
        selectSpeedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectSpeedView.showSelectSpeedView()
    }
    
    private func addBarrageSetView(){
        animationHiddenVideoOperationView()
        barrageView.removeFromSuperview()
        view.addSubview(barrageView)
        barrageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        barrageView.showBarrageView()
    }
    
    private func removeVideoOperitionView(){
        if view.subviews.contains(selectEpisodeView) {
            selectEpisodeView.hiddenSelectEpView()
        }
        if view.subviews.contains(selectQualityView)  {
            selectQualityView.hiddenSelectQualityView()
        }
        if view.subviews.contains(selectSpeedView)  {
            selectSpeedView.hiddenSelectSpeedView()
        }
        if view.subviews.contains(barrageView) {
            barrageView.hiddenBarrageView()
        }
    }
    
    
    
//   添加
    private func addDragPlayerTimeView(){
        dragPlayerTimeView.removeFromSuperview()
        view.addSubview(dragPlayerTimeView)
        dragPlayerTimeView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 60))
        }
    }
    
//    移除
    private func removeDragPlayerTimeView(){
        dragPlayerTimeView.removeFromSuperview()
    }
    
    private func addBarragePlayView(){
        barragePlayView.removeFromSuperview()
        playerManagerView?.addSubview(barragePlayView)
        barragePlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func removeBarragePlayView(){
        barragePlayView.removeFromSuperview()
    }
    
    private func addLongSpeedView(){
        longSpeedView.removeFromSuperview()
        view.addSubview(longSpeedView)
        longSpeedView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 176, height: 48))
        }
    }
    
    private func removeLongSpeedView(){
        longSpeedView.removeFromSuperview()
    }
    
    private func addVolumeView(){
        volumeView.removeFromSuperview()
        view.addSubview(volumeView)
        volumeView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 176, height: 48))
        }
    }
    
    private func removeVolumeView(){
        volumeView.removeFromSuperview()
    }
    
    private func addLuminanceView(){
        brightnessView.removeFromSuperview()
        view.addSubview(brightnessView)
        brightnessView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 176, height: 48))
        }
    }
    
    private func removeLuminanceView(){
        brightnessView.removeFromSuperview()
    }
    
    private func addBarrageInputView(){
        barrageInputView.removeFromSuperview()
        view.addSubview(barrageInputView)
        barrageInputView.responseTextField()
        barrageInputView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        暂停播放
        playerManagerView?.pausePlayer()
        bottomView.updateBtnStatus = false
    }
    
    private func removeBarrageInputView(){
        barrageInputView.removeFromSuperview()
        playerManagerView?.startPlayer()
        bottomView.updateBtnStatus = true
    }
    
    private func initPlayerManagerView(){
        loadingView.isHidden = false;
        playerManagerView?.removeFromSuperview()
        let playerView = AnAnVideoPlayerManager(playerUrl: playerUrl ?? "")
        
        playerView.playerStatusBlock = {[weak self] status in
            guard let `self` = self else { return }
            switch status {
            case .readyToPlay:
//                播放视频
                self.playerManagerView?.startPlayer()
                self.startPlayerVideo()
                self.syncPlayerStatus(stauts: .PlayerStatusReadyToPlay)
                break
            default:
                break
            }
        }
        playerView.playerDidEndBlock = {[weak self] in
//            播放结束
            print("播放结束")
//            判断是否有下一集，有切换到下一集
            self?.nextPlayerVideo()
            self?.syncPlayerStatus(stauts: .PlayerStatusEndPlay)
        }
        view.addSubview(playerView)
        view.sendSubviewToBack(playerView)
        playerManagerView = playerView
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addBarragePlayView()
    }
//    播放视频
    private func startPlayerVideo(){
        loadingView.isHidden = true
        NetSpeed.shared.stop()
        bottomView.playerManagerView = playerManagerView
    }
//    播放下一集
    private func nextPlayerVideo(){
        guard let count = episodeList?.count else { return }
        if currentPlayerEpisode < count-1{
            sid = episodeList?[currentPlayerEpisode+1].sid
            requestDetailPlayerInfoData()
            currentPlayerEpisode += 1
        }
    }
//    同步播放状态
    private func syncPlayerStatus(stauts:PlayerStatus){
        playerManagerView?.ananPlayerStatusBlock!(stauts)
    }
    
    private func initTimer() {
        viewHiddenTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[weak self] timer in
            self?.hiddenViewTimerCount -= 1
            if self?.hiddenViewTimerCount == 0{
                self?.hiddenViewTimerCount = 5
                self?.animationHiddenVideoOperationView()
                self?.cancelTimer()
            }
        }
        if let curTimer:Timer = viewHiddenTimer {
            RunLoop.main.add(curTimer, forMode: .common)
        }
    }
    
    fileprivate func animationHiddenVideoOperationView(){
        topView.snp.updateConstraints { make in
            make.top.equalTo(-38)
        }
        bottomView.snp.updateConstraints { make in
            make.bottom.equalTo(bottomHeight)
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.view.layoutIfNeeded()
        }completion: {[weak self] _ in
            self?.topView.isHidden = true
            self?.bottomView.isHidden = true
        }
    }
    
    fileprivate func animationShowVideoOperationView() {
        topView.snp.updateConstraints { make in
            make.top.equalToSuperview()
        }
        bottomView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.topView.isHidden = false
            self?.bottomView.isHidden = false
            self?.view.layoutIfNeeded()
        }
    }

    @objc fileprivate func tapClick(){
        removeVideoOperitionView()
        
        if topView.isHidden || bottomView.isHidden {
            initTimer()
            animationShowVideoOperationView()
        }
    }
    
    @objc func doubleTapClick() {
        if let playing = playerManagerView?.isPlaying, playing{
//            暂停
            playerManagerView?.pausePlayer()
            bottomView.updateBtnStatus = false
            barragePlayView.pauseBarrage()
        }else {
//            播放
            playerManagerView?.startPlayer()
            bottomView.updateBtnStatus = true
            barragePlayView.resumeBarrage()
        }
    }
    
    //    拖拽手势方法
    @objc func panDirection(panGesture:UIPanGestureRecognizer) {
//        手指在视图上移动的速度，用于判断在水平方向还是竖直方向滑动
        let velocityPoint = panGesture.velocity(in: view)
//        手指在视图上的位置
        let locationPoint = panGesture.location(in: view)
        
        switch panGesture.state {
        case .began:
            let x = abs(velocityPoint.x)
            let y = abs(velocityPoint.y)
            print("began--->\(locationPoint.y)")
            if x > y {
//                水平方向滑动
                print("水平方向滑动")
                
                slidingDirection = .SlidingDirectionLeftOrRight
                horizontalStateBeginValue(value: locationPoint.x)
                let movePoint = panGesture.translation(in: view)
                oldHorizontalLocation = movePoint.x
            }else if x < y{
//                竖直方向滑动
                print("竖直方向滑动")
                slidingDirection = .SlidingDirectionUpOrDown
                if locationPoint.x <= AnAnAppDevice.an_screenWidth()/2 {
//                    调节屏幕亮度
                    addLuminanceView()
                    verticalStateBeginIsVolume(isVolume: false)
                    oldBrightnessLocation = locationPoint.y
                }else{
//                    调节音量
                    addVolumeView()
                    verticalStateBeginIsVolume(isVolume: true)
                    oldVolumeLocation = locationPoint.y
                }
            }
            break
        case .changed:
//            开始滑动
            print("y--->\(locationPoint.y),x--->\(locationPoint.x)")
            switch slidingDirection {
            case .SlidingDirectionUpOrDown:
                verticalStateChangedValue(value: locationPoint.y)
                guard let `isVolume` = isVolume else { return }
                if isVolume {
                    oldVolumeLocation = locationPoint.y
                }else {
                    oldBrightnessLocation = locationPoint.y
                }
                break
            case .SlidingDirectionLeftOrRight:
//                if x > y{
                    let movePoint = panGesture.translation(in: view)
                    var loction:CGFloat = 0.0
                    var isAdd:Bool = false
                    if let oldLocation = oldHorizontalLocation{
                        if oldLocation > movePoint.x{
                            //                        向左
                            loction = oldLocation - movePoint.x
                            isAdd = false
                        }else{
                            loction = movePoint.x - oldLocation
                            isAdd = true
                        }
                        horizontalStateChangedValue(value: Float(loction),isAdd: isAdd)
                    }
//                }
                break
            default:
                break
            }
            break
        case .ended:
            switch slidingDirection {
            case .SlidingDirectionUpOrDown:
                guard let `isVolume` = isVolume else { return }
                if isVolume {
//                    移除音量提示视图
                    removeVolumeView()
                }else{
                    removeLuminanceView()
                }
                break
            case .SlidingDirectionLeftOrRight:
                let movePoint = panGesture.translation(in: view)
                oldHorizontalLocation = movePoint.x
                horizontalStateEndValue(value: movePoint.x)
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
//    长按触发2倍速播放
    @objc func longDirection(longGesture:UILongPressGestureRecognizer) {
        switch longGesture.state {
        case .possible:
            break
        case .began:
            addLongSpeedView()
            self.playerManagerView?.playerRate = 2
//            开始
            break
        case .changed:
//            长按中
            break
        case .ended:
            removeLongSpeedView()
            self.playerManagerView?.playerRate = 1
            break
        case .cancelled:
            break
        case .failed:
            break
        case .recognized:
            break
        default:
            break
        }
    }
    
//    监听屏幕旋转方向
    @objc fileprivate func orientationDidChange() {
        if AnAnScreenTool.shared.isForcingOrientation {
                return
            }
        let o = UIDevice.current.orientation
            guard o == .portrait || o == .landscapeLeft || o == .landscapeRight else {
                return
            }

        // 如果当前是自动模式，让系统自己转就够了，不要再强制
        if currentOrientation == .set_auto {
            return
        }

        // 只有在你“锁定横/竖”的业务模式下，才去强制旋转
        switch o {
        case .portrait:
            AnAnScreenTool.shared.switchScreenOrientation(vc: self, mode: .set_port)
        case .landscapeLeft:
            AnAnScreenTool.shared.switchScreenOrientation(vc: self,
                                                          mode: .set_land,
                                                          deviceOrientation: .landscapeLeft)
        case .landscapeRight:
            AnAnScreenTool.shared.switchScreenOrientation(vc: self,
                                                          mode: .set_land,
                                                          deviceOrientation: .landscapeRight)
        default:
            break
        }
    }
    deinit {
        playerManagerView?.removeFromSuperview()
        playerManagerView = nil
        NotificationCenter.default.removeObserver(self)
        cancelTimer()
        print("播放视图销毁")
    }
    
    private func cancelTimer(){
        if viewHiddenTimer != nil {
            viewHiddenTimer?.invalidate()
            viewHiddenTimer = nil
        }
    }
}


extension AnAnVideoPlayerViewController:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if view.subviews.contains(selectEpisodeView) {
            if touch.view != selectEpisodeView {
                return false
            }
        }
        if view.subviews.contains(selectQualityView)  {
            if touch.view != selectQualityView {
                return false
            }
        }
        if view.subviews.contains(selectSpeedView) {
            if touch.view != selectSpeedView {
                return false
            }
        }
        if view.subviews.contains(barrageView) {
            if touch.view != barrageView {
                return false
            }
        }
        return true
    }
}
// 请求网络数据
extension AnAnVideoPlayerViewController{
    func requestDetailPlayerInfoData() {
//        关闭进度更新定时器
        bottomView.closeProgressAndTime()
        AnAnRequest.shared.provider.requestModel(.moviePlayerInfo(seasonId: dramaId ?? "", dramaId: dramaId ?? "", episodeSid: sid ?? "", quality: quality ?? "SD"), model: WatchInfoModel.self) {[weak self] returnData, code in
            guard let `self` else {return}
            self.switchPlayerEpisode(currentPlayerUrl: returnData?.m3u8?.url)
//            开启
            self.bottomView.openProgressAndTime()
            
        }failure: { error in

        }
    }

//    切换剧集
    fileprivate func switchPlayerEpisode(currentPlayerUrl:String?){
//    移除视频播放，重新添加新的，显示loading
//        AnAnPlayerUrlParse 视频地址解码
        AnAnPlayerUrlParse.playerUrlParse(url: currentPlayerUrl ?? "") {[weak self] parseUrl in
            self?.removePlayerManagerView()
//            self?.loadingView.isHidden = false
            self?.playerUrl = parseUrl
            self?.addPlayerManagerView()
            self?.topView.movieName = String(format: "%@ 第%d集", self?.videoDetail?.dramaInfo?.title ?? "",(self?.currentPlayerEpisode ?? 0)+1)
//            updateVideoDetailSelectEpisodeBlock!(currentPlayerEpisode)
        }
    }
    
//    移除视频播放
    fileprivate func removePlayerManagerView(){
        playerManagerView?.stopPlayer()
        playerManagerView?.removeFromSuperview()
    }
//    添加视频播放
    fileprivate func addPlayerManagerView(){
//        防止重复添加
        initPlayerManagerView()
    }
}

// 调节音量，屏幕亮度，播放进度
extension AnAnVideoPlayerViewController{
//    获取当前音量
    private func getSystemVolumValue() -> Float{
        do{
            try AVAudioSession.sharedInstance().setActive(true)
        }catch let error as NSError{
            print("error--->\(error)")
        }
        let currentVolume = AVAudioSession.sharedInstance().outputVolume
        return currentVolume
    }
//    更新手机音量
    private func updateSystemVolumValue(value:CGFloat,isAdd:Bool){
        if let volume = currentVolume {
            var newVolume:Float = 0.0
            if isAdd {
                newVolume = volume + Float(value)
            }else {
                newVolume = volume - Float(value)
            }
            if (newVolume > 1){
                newVolume = 1
            }
            if (newVolume < 0){
                newVolume = 0
            }
            currentVolume = newVolume
            print("currentBrightness ====>\(newVolume), value ===>\(value)")
            MPVolumeView.setVolume(newVolume)
            volumeView.volumeValue = newVolume
        }
    }
    
//    获取当前屏幕亮度
    private func getCurrentScreenBrightness() -> CGFloat{
        return UIScreen.main.brightness
    }
//    更新屏幕亮度
    private func updateScreenBrightness(value:CGFloat,isAdd:Bool){
        if let currentBrightness = currentScrrenBrightness {
            var brightness:CGFloat = 0.0
            if isAdd {
                brightness = currentBrightness + value
            }else {
                brightness = currentBrightness - value
            }
            if (brightness > 1){
                brightness = 1
            }
            if (brightness < 0){
                brightness = 0
            }
            currentScrrenBrightness = brightness
            print("currentBrightness ====>\(brightness), value ===>\(value)")
            UIScreen.main.brightness = brightness
            brightnessView.brightnessValue = brightness;
        }
    }
    
    
//    开始水平滑动
    private func horizontalStateBeginValue(value:CGFloat){
        addDragPlayerTimeView()
    }
    
    private func horizontalStateChangedValue(value:Float,isAdd:Bool){
        
        if let currentPlayerTime = playerManagerView?.currentPlayerTime {
            print("ChangedValue------->\(value),currentPlayerTime--->\(currentPlayerTime)")
            var sumPlayerTime:Float = 0.0
            if isAdd {
                sumPlayerTime = Float(currentPlayerTime) + value
            }else{
                sumPlayerTime = Float(currentPlayerTime) - value
            }
            
            let timerStr = String(format: "%f", sumPlayerTime)
            print("timerStr ----> \(timerStr.playerTimerFormat())")
            dragPlayerTimeView.timeStr = timerStr.playerTimerFormat()
            
            bottomView.dragUpdateProgressTimeLabel(timeStr: timerStr.playerTimerFormat(), time: sumPlayerTime)
        }
    }
    
    private func horizontalStateEndValue(value:CGFloat){
        print("EndValue------->\(value)")
        removeDragPlayerTimeView()
    }
    
//    开始竖直滑动
    private func verticalStateBeginIsVolume(isVolume:Bool){
        self.isVolume = isVolume
        if isVolume {
            currentVolume = getSystemVolumValue()
        }else{
            currentScrrenBrightness = getCurrentScreenBrightness()
        }
    }
//
    private func verticalStateChangedValue(value:CGFloat){
        guard let `isVolume` = isVolume else { return }
        if isVolume {
            if let startLocation = oldVolumeLocation {
                var volume:CGFloat = 0
                var isAdd:Bool = false
                if startLocation > value {
//                    向上滑动
                    volume = startLocation - value
                    isAdd = true
                }else{
//                    向下滑动
                    volume = value - startLocation
                    isAdd = false
                }
                updateSystemVolumValue(value: volume/AnAnAppDevice.an_screenWidth(), isAdd: isAdd)
            }
        }else{
            print("value----->\(value)")
            if let startLocation = oldBrightnessLocation {
                var brightness:CGFloat = 0
                var isAdd:Bool = false
                if startLocation > value {
//                    向上滑动
                    brightness = startLocation - value
                    isAdd = true
                }else{
//                    向下滑动
                    brightness = value - startLocation
                    isAdd = false
                }
                updateScreenBrightness(value: brightness/AnAnAppDevice.an_screenWidth(),isAdd: isAdd)
            }
        }
    }
    
    private func verticalStateEnded() {
        
    }
}

extension AnAnVideoPlayerViewController:NetSpeedProtocol{
    func didSent(octets: UInt32) {
        let upload = "upload \(String.formatSpeed(octets: octets))"
        print(upload)
    }
    
    func didReceived(octets: UInt32) {
        let download = "download \(String.formatSpeed(octets: octets))"
        print(download)
    }
    
}

extension MPVolumeView{
    static func hiddenView(){
        
    }
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
//        异步调节音量
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
