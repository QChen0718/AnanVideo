//
//  AnAnBarrageView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/26.
//  弹幕视图

//import UIKit
//
//class AnAnBarrageView: UIView {
//    var barrageTime:Timer?
////    接口返回弹幕数据
//    var barrageDataList:[AnAnBarrageDataModel?] = []
////    弹幕数据
//    var barrageInfoList:[AnAnBarrageInfo] = []
////    弹幕动画时间
//    var duration:CGFloat = 7.5
////    弹幕弹道高度
//    var lineHeight:CGFloat = 30
////    弹幕弹道之间的间距
//    var lineMargin:CGFloat = 5
////    弹幕弹道最大行数
//    var maxShowLineCount:Int = 3
////    记录轨道上是否有弹幕
//    var lineDict:[Int:AnAnBarrageInfo] = [:]
////    记录时间段的弹幕数
//    var subBarrageInfoList:[AnAnBarrageInfo] = []
////    时间间隔
//    let timeMargin:TimeInterval = 0.08
////    当前播放器
//    var playerManagerView:AnAnVideoPlayerManager?
////    准备中
//    var isPrepared:Bool{
//        set{
//            
//        }
//        get{
//            if lineHeight > 0 && duration > 0 && maxShowLineCount > 0 {
//                return true
//            }
//            return false
//        }
//    }
////    播放中
//    var isPlaying:Bool = false
////    暂停中
//    var isPauseing:Bool = false
////    当前弹幕开始时间
//    var currentBarrageStartTime:Int = 0
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.0)
//    }
//    
//    var videoDetail:AnAnDetailModel?{
//        didSet{
//            startBarrage()
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
////    获取弹幕数据
//    func requestBarrageListData() {
////        type:剧集类型
////        typeId:集ID
////        seasonId:季ID
//        let params:[String:Any] = ["type":"EPISODE","typeId":videoDetail?.watchInfo?.m3u8?.episodeSid ?? "","seasonId":videoDetail?.dramaInfo?.dramaId ?? ""]
//        AnAnRequest.shared.requestNewBarrageData(param: params) { model in
//            
//        }
//        
//        AnAnRequest.shared.requestCDNBarrageData(episodeId:videoDetail?.watchInfo?.m3u8?.episodeSid ?? "") {[weak self] modelList in
//            guard let `self` else {return}
//            self.barrageDataList = modelList
////            组装弹幕内容
//            DispatchQueue.global().async {
//                var curInfoList:[AnAnBarrageInfo] = []
//                modelList.forEach { model in
//                    let paramsArray = model?.p?.components(separatedBy: ",")
//                    let barrageInfo = AnAnBarrageInfo()
//                    barrageInfo.barrageId = paramsArray?[7]
//                    barrageInfo.timePoint = TimeInterval(paramsArray?.first ?? "")
//                    barrageInfo.barrageColor = paramsArray?[3] ?? ""
//                    barrageInfo.barrageContent = NSMutableAttributedString(string: model?.d ?? "")
//                    barrageInfo.barrageCover = model?.a
//                    curInfoList.append(barrageInfo)
//                }
//                DispatchQueue.main.async {
//                    self.barrageInfoList = curInfoList
////                    self.getPlayTimeBarrageDatatest()
//                }
//            }
//            
//        }
//    }
//        
//    private func createTimer() {
//        if barrageTime == nil {
//            let timer = Timer.scheduledTimer(timeInterval: timeMargin, target: self, selector: #selector(getPlayTimeBarrageData), userInfo: nil, repeats: true)
//            RunLoop.current.add(timer, forMode: .common)
//            barrageTime = timer
//        }
//    }
//    
//    private func cancelTimer() {
//        barrageTime?.invalidate()
//    }
//    
////    获取播放时间段弹幕
//    @objc func getPlayTimeBarrageData(){
////        判断视频是否在加载中
////        获取当前播放的时间
//        
//        subBarrageInfoList.forEach { info in
//            guard var leftTime = info.timerMargin else {return}
//            leftTime -= timeMargin
//            info.timerMargin = leftTime
//        }
//        
//        guard var barrageArray = getBarrages(withTimeStart: playerManagerView?.currentPlayerTime ?? 0, timeLength: timeMargin*5) else {return}
//        
////        存在弹幕
//        if !barrageArray.isEmpty {
////            移除当前获取的弹幕数组中已经展示的弹幕，创建未展示的弹幕数据
//            let showBarrages = getCurrentShowBarrages()
//            showBarrages.forEach { barrageInfo in
//                barrageArray.removeAll { curInfo in
//                    barrageInfo.barrageId == curInfo.barrageId
//                }
//            }
//            let uniqueArray = Array(Set(barrageArray))
//            for i in 0..<uniqueArray.count {
////                创建弹幕lable展示弹幕
//                createBarrage(barInfo: uniqueArray[i])
//            }
//        }
////        print("===>弹幕数\(barrageArray.count)")
//    }
////    创建弹幕
//    func createBarrage(barInfo:AnAnBarrageInfo) {
//        let btn = AnAnBarrageBtn(type: .custom)
//        btn.setTitleColor(.white, for: .normal)
//        btn.layer.borderWidth = 1
//        btn.layer.borderColor = UIColor.white.cgColor
//        btn.layer.cornerRadius = 5
//        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
//        btn.titleEdgeInsets = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
//        btn.setAttributedTitle(barInfo.barrageContent, for: .normal)
//        self.addSubview(btn)
//        barInfo.barrageBtn = btn
//        barInfo.timerMargin = duration
//        
//        let width = calculateStringWidth(string: barInfo.barrageContent?.string ?? "",font: .systemFont(ofSize: 15, weight: .regular))
//        for i in 0..<self.maxShowLineCount {
//            let oldInfo = lineDict[i]
//            if lineDict[i] == nil {
//                barInfo.lineCount = i
//                lineDict[barInfo.lineCount] = barInfo
//                subBarrageInfoList.append(barInfo)
//                barInfo.barrageBtn?.frame = CGRect(x: self.frame.width, y: (self.lineHeight + self.lineMargin) * CGFloat(i) + 44 , width: width, height: lineHeight)
//                
//                    self.performAnimationWithDuration(duration: barInfo.timerMargin ?? 0, info: barInfo)
//                break
//            }
//            if !judgeIsRunintoWithFirstDanmakuInfo(info: oldInfo, lastInfo: barInfo) {
//                barInfo.lineCount = i
//                lineDict[barInfo.lineCount] = barInfo
//                subBarrageInfoList.append(barInfo)
//                barInfo.barrageBtn?.frame = CGRect(x: self.frame.width, y: (self.lineHeight + self.lineMargin) * CGFloat(i) + 44 , width: width, height: lineHeight)
//                    self.performAnimationWithDuration(duration: barInfo.timerMargin ?? 0, info: barInfo)
//                break
//            }else if (i == maxShowLineCount-1){
//                btn.removeFromSuperview()
//                barrageInfoList.removeAll { info in
//                    return info.barrageId == barInfo.barrageId;
//                }
//            }
//        }
//        
//    }
//    
////    获取当前屏幕中已经展示的弹幕
//    func getCurrentShowBarrages()->[AnAnBarrageInfo] {
//        var barrages:[AnAnBarrageInfo] = []
//        self.subviews.forEach { view in
//            if view.isKind(of: AnAnBarrageBtn.self) {
//                let barrageBtn = view as! AnAnBarrageBtn
//                barrages.append(barrageBtn.barrageInfo ?? AnAnBarrageInfo())
//            }
//        }
//        return barrages
//    }
////    获取时间段内的弹幕数
//    func getBarrages(withTimeStart timeStart: Double, timeLength: CGFloat) -> [AnAnBarrageInfo]? {
//        if self.barrageInfoList.isEmpty {
//            return []
//        }
////
//        let allStart = barrageInfoList.first?.timePoint ?? 0
//        let last = barrageInfoList.last?.timePoint ?? 0
//          
//        // timeStart: 视频播放时间, allStart: 第一条弹幕时间, last: 最后一条弹幕时间
//        if timeStart + timeLength < allStart || last < timeStart {
//            // 时间范围在所有弹幕时间范围之外，没有弹幕
//            return nil
//        }
//          
//        // 弹幕匀速播放, timeStart 开始重 searchIndex 弹幕位置放
//        var searchIndex: Int = 0
//        if timeStart > allStart {
//            searchIndex = Int((timeStart - allStart) / (last - allStart) * CGFloat(barrageInfoList.count))
//            if searchIndex >= barrageInfoList.count {
//                searchIndex = barrageInfoList.count - 1
//            }
//        }
//          
//        // 修正播放timeStart开始播放的弹幕
//        var barrageType: AnAnBarrageInfo? = barrageInfoList[searchIndex]
//        while barrageType?.timePoint ?? 0 >= timeStart && searchIndex > 0 {
//            barrageType = barrageInfoList[searchIndex - 1]
//            searchIndex -= 1
//        }
//        while barrageType?.timePoint ?? 0 < timeStart && searchIndex < barrageInfoList.count - 1 {
//            barrageType = barrageInfoList[searchIndex + 1]
//            searchIndex += 1
//        }
//          
//        var array: [AnAnBarrageInfo] = []
//        for index in searchIndex..<barrageInfoList.count {
//            barrageType = barrageInfoList[index]
//            if barrageType?.timePoint ?? 0 < timeStart + timeLength {
//                array.append(barrageType!)
//            } else {
//                break
//            }
//        }
//          
//        return array
//    }
//    
////  发送弹幕
//    func sendBarrage() {
//        
//    }
//    
////  开始弹幕
//    func startBarrage() {
////        请求弹幕数据
//        requestBarrageListData()
//        playBarrage()
//        createTimer()
//        isPlaying = true
//        isPauseing = false
//    }
////  暂停弹幕
//    func pauseBarrage() {
//        barrageTime?.fireDate = .distantFuture
//            for label in subviews.filter({ $0 is UIButton }) {
//                guard let label = label as? UIButton else { continue }
//                let layer = label.layer
//                var rect = label.frame
//                if let presentationLayer = layer.presentation() {
//                    rect = presentationLayer.frame
//                }
//                label.frame = rect
//                label.layer.removeAllAnimations()
//            }
//            isPauseing = true
//            isPlaying = false
//    }
////  继续弹幕
//    func resumeBarrage() {
//        print("barrageViewDebug: resume")
//        guard isPrepared && !isPlaying else {
//            print("barrageViewDebug: resume doing nothing")
//            return
//        }
//      
//        DispatchQueue.main.async {
//            self.subBarrageInfoList.forEach { info in
//                self.performAnimationWithDuration(duration: info.timerMargin ?? 0, info: info)
//                
//            }
//        }
//      
//        let timeMarginSeconds = Double(timeMargin) // 假设timeMargin是一个TimeInterval或者可以转换为TimeInterval的类型
//        let delayTime = DispatchTime.now() + timeMarginSeconds
//        DispatchQueue.main.asyncAfter(deadline: delayTime) {
//            self.barrageTime?.fireDate = .distantPast
//        }
//        
//    }
////  停止弹幕
//    func stopBarrage() {
//        
//    }
////  清除弹幕
//    func clearBarrage() {
//        
//    }
////  播放弹幕
//    func playBarrage() {
////        没有准备好，或者已经在播放弹幕
//        if isPrepared == false || isPlaying == true {
//            return
//        }
//        
//        DispatchQueue.main.async {
//            self.barrageInfoList.forEach { model in
//                self.performAnimationWithDuration(duration: model.timerMargin ?? 0, info: model)
//            }
//        }
//        let delayTime = DispatchTime.now() + timeMargin*Double(NSEC_PER_SEC)
//        DispatchQueue.main.asyncAfter(deadline: delayTime) {
//            self.barrageTime?.fireDate = Date.distantPast
//        }
//        
//    }
////    弹幕播放动画
//    func performAnimationWithDuration(duration:TimeInterval,info:AnAnBarrageInfo) {
//        guard let label = info.barrageBtn else {return}
//        
//        let endFrame = CGRect(x: -(label.frame.size.width), y: label.frame.origin.y, width: label.frame.size.width, height: label.frame.size.height)
//        
////        if ([label.layer.animationKeys].count != 0) {
////            print("====>\(label.layer.animationKeys)")
////            //已经在运行动画了
////            return;
////        }
//        
//        UIView.animate(withDuration: duration, delay: 0,options: .curveLinear) {
//            label.frame = endFrame
//        }completion: { finished in
//            if finished {
//                label.removeFromSuperview()
//                
////                销毁已经动画结束的弹幕，在弹幕轨道上创建新的弹幕
//                self.subBarrageInfoList.removeAll { subinfo in
//                    return subinfo.barrageId == info.barrageId
//                }
//            }
//        }
//    }
//    
////    弹幕碰撞检测，防止弹幕重叠在一起
//    func judgeIsRunintoWithFirstDanmakuInfo(info:AnAnBarrageInfo?,lastInfo:AnAnBarrageInfo?) -> Bool {
//        if info?.barrageBtn == nil {
//            return false
//        }
//        guard let firstContent = info?.barrageContent?.string else { return true}
//        guard let lastContent = lastInfo?.barrageContent?.string else { return true}
//        let curSize = calculateStringWidth(string: firstContent,font: .systemFont(ofSize: 15, weight: .regular))
//        let lastSize = calculateStringWidth(string: lastContent,font: .systemFont(ofSize: 15, weight: .regular))
//        let firstSpeed = barragePlaySpeed(w: curSize)
//        let lastSpeed = barragePlaySpeed(w: lastSize)
//        let firstRight = (info?.timerMargin ?? 0)*firstSpeed
//
//        if (info?.timerMargin ?? 0) <= 1 {
//            return false
//        }
////        两个弹幕之间的间隔
//        if self.frame.size.width - firstRight > 20 {
////            前一个弹幕的速度要快后一个弹幕的速度，这样才能不会碰撞遮挡
//            
//            if lastSpeed <= firstSpeed {
//                return false
//            }
//            else{
//                let lastEndLeft = self.frame.size.width - lastSpeed * (info?.timerMargin ?? 0)
//                if lastEndLeft >= 3 {
//                    return false
//                }
//            }
//        }
//        return true
//    }
//    
////    计算弹幕速度
//    func barragePlaySpeed(w:CGFloat) -> CGFloat {
//        return (self.bounds.size.width + w)/duration;
//    }
//    
////    计算文字内容大小
//    func calculateStringWidth(string: String, font: UIFont) -> CGFloat {
//        // 创建一个包含所需属性的字典
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: font,
//            .foregroundColor: UIColor.black  // 可以根据需要设置其他属性，例如颜色
//        ]
//          
//        // 使用 NSString 的 size(withAttributes:) 方法计算字符串的大小
//        let size = string.size(withAttributes: attributes)
//          
//        // 返回宽度
//        return size.width+10
//    }
//}

import UIKit

class AnAnBarrageView: UIView {
    
    // MARK: - 配置参数
    var duration: CGFloat = 7.5
    var lineHeight: CGFloat = 30
    var lineMargin: CGFloat = 5
    var maxShowLineCount: Int = 3
    let timeMargin: TimeInterval = 0.08
    
    // MARK: - 数据管理
    private var processedBarrageIDs = Set<String>()
    private var barrageDataList: [AnAnBarrageDataModel?] = []
    private var barrageInfoList: [AnAnBarrageInfo] = []
    private var activeBarrageViews = NSHashTable<AnAnBarrageBtn>.weakObjects()
    
    // MARK: - 轨道管理
    private struct BarrageTrack {
        var currentBarrage: AnAnBarrageInfo?
        var nextAvailableTime: TimeInterval = 0
    }
    private var tracks: [BarrageTrack] = []
    
    // MARK: - 播放控制
    private var barrageTimer: Timer?
    var isPlaying: Bool = false
    var isPaused: Bool = false
    weak var playerManagerView: AnAnVideoPlayerManager?
    
    // MARK: - 动画控制
    private var animators: [String: UIViewPropertyAnimator] = [:]
    private let barrageProcessingQueue = DispatchQueue(
        label: "com.anan.barrage.processing",
        qos: .userInteractive,
        attributes: .concurrent
    )
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: "000000", alpha: 0.0)
        setupTracks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTracks() {
        tracks = Array(repeating: BarrageTrack(), count: maxShowLineCount)
    }
    
    // MARK: - 外部接口
    var videoDetail: AnAnDetailModel? {
        didSet {
            startBarrage()
        }
    }
    
    func startBarrage() {
        requestBarrageListData()
        playBarrage()
        createTimer()
        isPlaying = true
        isPaused = false
    }
    
    // MARK: - 播放控制
    func playBarrage() {
        guard !isPlaying, !isPaused else { return }
        
        isPlaying = true
        isPaused = false
        
        // 首次启动时立即调度一次弹幕
        scheduleBarrage()
        
        // 启动定时器
        if barrageTimer == nil {
            createTimer()
        } else {
            barrageTimer?.fireDate = Date()
        }
        
        // 恢复所有动画
        animators.values.forEach { $0.startAnimation() }
    }

    func pauseBarrage() {
        isPaused = true
        isPlaying = false
        barrageTimer?.fireDate = .distantFuture
        animators.values.forEach { $0.stopAnimation(true) }
    }
    
    func resumeBarrage() {
        guard !isPlaying else { return }
        
        isPlaying = true
        isPaused = false
        
        animators.values.forEach { animator in
            animator.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeMargin) {
            self.barrageTimer?.fireDate = .distantPast
        }
    }
    
    func stopBarrage() {
        clearBarrage()
        cancelTimer()
        isPlaying = false
        isPaused = false
    }
    
    func clearBarrage() {
        animators.removeAll()
        subviews.forEach { view in
            if view is AnAnBarrageBtn {
                view.removeFromSuperview()
            }
        }
        tracks = Array(repeating: BarrageTrack(), count: maxShowLineCount)
        activeBarrageViews.removeAllObjects()
    }
    
    // MARK: - 弹幕数据处理
    private func requestBarrageListData() {
        let params: [String: Any] = [
            "type": "EPISODE",
            "typeId": videoDetail?.watchInfo?.m3u8?.episodeSid ?? "",
            "seasonId": videoDetail?.dramaInfo?.dramaId ?? ""
        ]
        
        AnAnRequest.shared.requestCDNBarrageData(episodeId: videoDetail?.watchInfo?.m3u8?.episodeSid ?? "") { [weak self] modelList in
            guard let self = self else { return }
            
            // 过滤已存在的弹幕
            let newModels = modelList.filter { model in
                let barrageID = model?.p?.components(separatedBy: ",")[7] ?? ""
                return !self.processedBarrageIDs.contains(barrageID)
            }
            
            // 更新去重标记
            newModels.forEach { model in
                if let barrageID = model?.p?.components(separatedBy: ",")[7] {
                    self.processedBarrageIDs.insert(barrageID)
                }
            }
            
            self.barrageProcessingQueue.async {
                var curInfoList = [AnAnBarrageInfo]()
                
                newModels.forEach { model in
                    let paramsArray = model?.p?.components(separatedBy: ",")
                    let barrageInfo = AnAnBarrageInfo()
                    barrageInfo.barrageId = paramsArray?[7]
                    barrageInfo.timePoint = TimeInterval(paramsArray?.first ?? "") ?? 0
                    barrageInfo.barrageColor = paramsArray?[3] ?? ""
                    barrageInfo.barrageContent = NSMutableAttributedString(string: model?.d ?? "")
                    barrageInfo.barrageCover = model?.a
                    curInfoList.append(barrageInfo)
                }
                
                DispatchQueue.main.async {
                    self.barrageInfoList.append(contentsOf: curInfoList)
                    self.barrageInfoList.sort { ($0.timePoint ?? 0.0) < ($1.timePoint ?? 0.0) }
                }
            }
        }
    }
    
    // MARK: - 弹幕调度
    private func createTimer() {
        if barrageTimer == nil {
            barrageTimer = Timer.scheduledTimer(
                timeInterval: timeMargin,
                target: self,
                selector: #selector(scheduleBarrage),
                userInfo: nil,
                repeats: true
            )
            RunLoop.current.add(barrageTimer!, forMode: .common)
        }
    }
    
    private func cancelTimer() {
        barrageTimer?.invalidate()
        barrageTimer = nil
    }
    
    @objc private func scheduleBarrage() {
        guard let currentTime = playerManagerView?.currentPlayerTime else { return }
        
        // 获取当前时间段应该显示的弹幕
        let timeRange = currentTime...(currentTime + timeMargin * 5)
        let barragesToShow = getBarrages(in: timeRange)
        
        // 过滤掉已经在显示的弹幕
        let activeBarrages = activeBarrageViews.allObjects.compactMap { $0.barrageInfo?.barrageId }
        let newBarrages = barragesToShow.filter { !activeBarrages.contains($0.barrageId ?? "") }
        
        // 添加新弹幕
        newBarrages.forEach { barrage in
            if let trackIndex = findAvailableTrack(for: barrage) {
                addBarrageToTrack(barrage: barrage, trackIndex: trackIndex)
            }
        }
        
        // 清理已完成动画的弹幕
        cleanUpFinishedBarrages()
    }
    
    private func getBarrages(in timeRange: ClosedRange<Double>) -> [AnAnBarrageInfo] {
        guard !barrageInfoList.isEmpty else { return [] }
        
        let firstBarrageTime = barrageInfoList.first?.timePoint ?? 0
        let lastBarrageTime = barrageInfoList.last?.timePoint ?? 0
        
        // 不在弹幕时间范围内
        if timeRange.upperBound < firstBarrageTime || lastBarrageTime < timeRange.lowerBound {
            return []
        }
        
        // 二分查找提高效率
        var startIndex = 0
        var endIndex = barrageInfoList.count - 1
        
        // 查找起始位置
        while startIndex <= endIndex {
            let mid = (startIndex + endIndex) / 2
            if (barrageInfoList[mid].timePoint ?? 0.0) >= timeRange.lowerBound {
                endIndex = mid - 1
            } else {
                startIndex = mid + 1
            }
        }
        
        // 查找结束位置
        endIndex = barrageInfoList.count - 1
        let tempStart = startIndex
        startIndex = 0
        while startIndex <= endIndex {
            let mid = (startIndex + endIndex) / 2
            if (barrageInfoList[mid].timePoint ?? 0.0) <= timeRange.upperBound {
                startIndex = mid + 1
            } else {
                endIndex = mid - 1
            }
        }
        
        return Array(barrageInfoList[tempStart..<startIndex])
    }
    
    // MARK: - 弹幕渲染
    private func findAvailableTrack(for barrage: AnAnBarrageInfo) -> Int? {
        let currentTime = CACurrentMediaTime()
        
        for (index, track) in tracks.enumerated() {
            if track.nextAvailableTime <= currentTime {
                return index
            }
            
            // 如果轨道被占用，检查是否会碰撞
            if let currentBarrage = track.currentBarrage,
               !willCollide(existing: currentBarrage, new: barrage, at: index) {
                return index
            }
        }
        
        return nil
    }
    
    private func willCollide(existing: AnAnBarrageInfo, new: AnAnBarrageInfo, at trackIndex: Int) -> Bool {
        guard let existingBtn = existing.barrageBtn else { return false }
        
        // 计算现有弹幕的当前位置
        let existingFrame = existingBtn.layer.presentation()?.frame ?? existingBtn.frame
        let existingRight = existingFrame.maxX
        
        // 计算新弹幕需要的安全距离
        let newWidth = calculateStringWidth(string: new.barrageContent?.string ?? "",
                                          font: .systemFont(ofSize: 15, weight: .regular))
        let safeDistance = newWidth + 20
        
        // 现有弹幕如果已经快到屏幕左侧，则不碰撞
        if existingRight + safeDistance < bounds.width {
            return false
        }
        
        return true
    }
    
    private func addBarrageToTrack(barrage: AnAnBarrageInfo, trackIndex: Int) {
        let width = calculateStringWidth(string: barrage.barrageContent?.string ?? "",
                                       font: .systemFont(ofSize: 15, weight: .regular))
        let height = lineHeight
        let y = (lineHeight + lineMargin) * CGFloat(trackIndex) + 44
        
        let barrageBtn = AnAnBarrageBtn(type: .custom)
        barrageBtn.setTitleColor(.white, for: .normal)
        barrageBtn.layer.borderWidth = 1
        barrageBtn.layer.borderColor = UIColor.white.cgColor
        barrageBtn.layer.cornerRadius = 5
        barrageBtn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        barrageBtn.titleEdgeInsets = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
        barrageBtn.setAttributedTitle(barrage.barrageContent, for: .normal)
        barrageBtn.frame = CGRect(x: bounds.width, y: y, width: width, height: height)
        barrageBtn.barrageInfo = barrage
        
        addSubview(barrageBtn)
        activeBarrageViews.add(barrageBtn)
        
        // 更新轨道状态
        tracks[trackIndex].currentBarrage = barrage
        tracks[trackIndex].nextAvailableTime = CACurrentMediaTime() + duration
        
        // 启动动画
        performAnimation(for: barrageBtn, duration: duration)
    }
    
    private func performAnimation(for button: AnAnBarrageBtn, duration: TimeInterval) {
        let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            button.frame.origin.x = -button.frame.width
        }
        
        animator.addCompletion { [weak self] _ in
            button.removeFromSuperview()
            if let barrageId = button.barrageInfo?.barrageId {
                self?.animators.removeValue(forKey: barrageId)
            }
            self?.activeBarrageViews.remove(button)
        }
        
        if let barrageId = button.barrageInfo?.barrageId {
            animators[barrageId] = animator
        }
        animator.startAnimation()
    }
    
    // MARK: - 工具方法
    private func cleanUpFinishedBarrages() {
        barrageInfoList = barrageInfoList.filter { info in
            if let barrageId = info.barrageId {
                return animators[barrageId] != nil
            }
            return false
        }
    }
    
    private func calculateStringWidth(string: String, font: UIFont) -> CGFloat {
        let size = string.size(withAttributes: [.font: font])
        return size.width + 10
    }
}
