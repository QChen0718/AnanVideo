//
//  AnAnBarrageView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/26.
//  弹幕视图

import UIKit

class AnAnBarrageView: UIView {
    var barrageTime:Timer?
//    接口返回弹幕数据
    var barrageDataList:[AnAnBarrageDataModel?] = []
//    弹幕数据
    var barrageInfoList:[AnAnBarrageInfo] = []
//    弹幕动画时间
    var duration:CGFloat = 5.5
//    弹幕弹道高度
    var lineHeight:CGFloat = 20
//    弹幕弹道之间的间距
    var lineMargin:CGFloat = 5
//    弹幕弹道最大行数
    var maxShowLineCount:Int = 5
//    记录轨道上是否有弹幕
    var lineDict:[Int:AnAnBarrageInfo] = [:]
//    记录时间段的弹幕数
    var subBarrageInfoList:[AnAnBarrageInfo] = []
//    记录已显示的弹幕（用于去重）
    var displayedBarrageSet: Set<String> = []
//    时间间隔
    let timeMargin:TimeInterval = 0.08
//    当前播放器
    weak var playerManagerView:AnAnVideoPlayerManager?
//    准备中
    var isPrepared:Bool{
        set{
            
        }
        get{
            if lineHeight > 0 && duration > 0 && maxShowLineCount > 0 {
                return true
            }
            return false
        }
    }
//    播放中
    var isPlaying:Bool = false
//    暂停中
    var isPauseing:Bool = false
//    当前弹幕开始时间
    var currentBarrageStartTime:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.0)
    }
    
    var videoDetail:AnAnDetailModel?{
        didSet{
            startBarrage()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    获取弹幕数据
    func requestBarrageListData() {
//        type:剧集类型
//        typeId:集ID
//        seasonId:季ID
        let params:[String:Any] = ["type":"EPISODE","typeId":videoDetail?.watchInfo?.m3u8?.episodeSid ?? "","seasonId":videoDetail?.dramaInfo?.dramaId ?? ""]
        AnAnRequest.shared.requestNewBarrageData(param: params) { model in
            
        }
        
        AnAnRequest.shared.requestCDNBarrageData(episodeId:videoDetail?.watchInfo?.m3u8?.episodeSid ?? "") {[weak self] modelList in
            guard let `self` else {return}
            self.barrageDataList = modelList
//            组装弹幕内容
            DispatchQueue.global().async {
                var curInfoList:[AnAnBarrageInfo] = []
                // 用于去重：记录同一时间相同内容的弹幕
                var duplicateSet = Set<String>()
                
                modelList.forEach { model in
                    let paramsArray = model?.p?.components(separatedBy: ",")
                    let timePoint = TimeInterval(paramsArray?.first ?? "") ?? 0.0
                    let content = model?.d ?? ""
                    
                    // 创建唯一标识：时间点（保留1位小数精度）+ 内容
                    let roundedTime = round(timePoint * 10) / 10  // 保留1位小数，避免精度问题
                    let uniqueKey = "\(roundedTime)_\(content)"
                    
                    // 过滤掉同一时间内容相同的弹幕
                    if duplicateSet.contains(uniqueKey) {
                        return
                    }
                    duplicateSet.insert(uniqueKey)
                    
                    let barrageInfo = AnAnBarrageInfo()
                    barrageInfo.barrageId = paramsArray?[7]
                    barrageInfo.timePoint = timePoint
                    barrageInfo.barrageColor = paramsArray?[3] ?? ""
                    barrageInfo.barrageContent = NSMutableAttributedString(string: content)
                    barrageInfo.barrageCover = model?.a
                    curInfoList.append(barrageInfo)
                }
                
                // 按时间点排序
                curInfoList.sort { ($0.timePoint ?? 0) < ($1.timePoint ?? 0) }
                
                DispatchQueue.main.async {
                    self.barrageInfoList = curInfoList
//                    self.getPlayTimeBarrageDatatest()
                }
            }
            
        }
    }
        
    private func createTimer() {
        if barrageTime == nil {
            let timer = Timer.scheduledTimer(timeInterval: timeMargin, target: self, selector: #selector(getPlayTimeBarrageData), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            barrageTime = timer
        }
    }
    
    private func cancelTimer() {
        barrageTime?.invalidate()
    }
    
//    获取播放时间段弹幕
    @objc func getPlayTimeBarrageData(){
//        判断视频是否在加载中
//        获取当前播放的时间
        
        subBarrageInfoList.forEach { info in
            guard var leftTime = info.timerMargin else {return}
            leftTime -= timeMargin
            info.timerMargin = leftTime
        }
        
        guard let barrageArray = getBarrages(withTimeStart: playerManagerView?.currentPlayerTime ?? 0, timeLength: timeMargin*Double(maxShowLineCount)) else {return}
        
//        存在弹幕
        if !barrageArray.isEmpty {
//            移除当前获取的弹幕数组中已经展示的弹幕，创建未展示的弹幕数据
            let showBarrages = getCurrentShowBarrages()
            let showBarrageIds = Set(showBarrages.compactMap { $0.barrageId })
            
            // 去重：过滤掉已展示的弹幕和重复的弹幕（同一时间相同内容）
            var seenBarrages: Set<String> = []
            var uniqueArray: [AnAnBarrageInfo] = []
            
            for barInfo in barrageArray {
                // 创建唯一标识：时间点（保留1位小数精度）+ 内容
                let timePoint = barInfo.timePoint ?? 0
                let roundedTime = round(timePoint * 10) / 10  // 保留1位小数，避免精度问题
                let content = barInfo.barrageContent?.string ?? ""
                let uniqueKey = "\(roundedTime)_\(content)"
                
                // 跳过已显示的弹幕（全局记录）
                if displayedBarrageSet.contains(uniqueKey) {
                    continue
                }
                
                // 跳过当前屏幕中已展示的弹幕（通过barrageId）
                if let barrageId = barInfo.barrageId, showBarrageIds.contains(barrageId) {
                    continue
                }
                
                // 跳过本次循环中重复的弹幕
                if seenBarrages.contains(uniqueKey) {
                    continue
                }
                
                seenBarrages.insert(uniqueKey)
                uniqueArray.append(barInfo)
            }
            
            for barInfo in uniqueArray {
                // 创建唯一标识并记录到全局已显示集合
                let timePoint = barInfo.timePoint ?? 0
                let roundedTime = round(timePoint * 10) / 10
                let content = barInfo.barrageContent?.string ?? ""
                let uniqueKey = "\(roundedTime)_\(content)"
                displayedBarrageSet.insert(uniqueKey)
                
//                创建弹幕lable展示弹幕
                createBarrage(barInfo: barInfo)
            }
        }
//        print("===>弹幕数\(barrageArray.count)")
    }
//    创建弹幕
    func createBarrage(barInfo:AnAnBarrageInfo) {
        let btn = AnAnBarrageBtn(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        btn.setAttributedTitle(barInfo.barrageContent, for: .normal)
        btn.barrageInfo = barInfo  // 设置弹幕信息，用于去重检查
        self.addSubview(btn)
        barInfo.barrageBtn = btn
        
        let width = calculateStringWidth(string: barInfo.barrageContent?.string ?? "",font: .systemFont(ofSize: 15, weight: .regular))
        // 根据宽度计算实际需要的动画时长，保持速度一致
        let actualDuration = calculateDurationForWidth(width: width)
        barInfo.timerMargin = actualDuration
        
        for i in 0..<self.maxShowLineCount {
            let oldInfo = lineDict[i]
            if lineDict[i] == nil {
                barInfo.lineCount = i
                lineDict[barInfo.lineCount] = barInfo
                subBarrageInfoList.append(barInfo)
                barInfo.barrageBtn?.frame = CGRect(x: self.frame.width, y: (self.lineHeight + self.lineMargin) * CGFloat(i) , width: width, height: lineHeight)
                
                    self.performAnimationWithDuration(duration: barInfo.timerMargin ?? 0, info: barInfo)
                break
            }
            if !judgeIsRunintoWithFirstDanmakuInfo(info: oldInfo, lastInfo: barInfo) {
                barInfo.lineCount = i
                lineDict[barInfo.lineCount] = barInfo
                subBarrageInfoList.append(barInfo)
                barInfo.barrageBtn?.frame = CGRect(x: self.frame.width, y: (self.lineHeight + self.lineMargin) * CGFloat(i) , width: width, height: lineHeight)
                    self.performAnimationWithDuration(duration: barInfo.timerMargin ?? 0, info: barInfo)
                break
            }else if (i == maxShowLineCount-1){
                btn.removeFromSuperview()
                barrageInfoList.removeAll { info in
                    return info.barrageId == barInfo.barrageId;
                }
            }
        }
        
    }
    
//    获取当前屏幕中已经展示的弹幕
    func getCurrentShowBarrages()->[AnAnBarrageInfo] {
        var barrages:[AnAnBarrageInfo] = []
        self.subviews.forEach { view in
            if view.isKind(of: AnAnBarrageBtn.self) {
                let barrageBtn = view as! AnAnBarrageBtn
                barrages.append(barrageBtn.barrageInfo ?? AnAnBarrageInfo())
            }
        }
        return barrages
    }
//    获取时间段内的弹幕数
    func getBarrages(withTimeStart timeStart: Double, timeLength: CGFloat) -> [AnAnBarrageInfo]? {
        if self.barrageInfoList.isEmpty {
            return []
        }
//
        let allStart = barrageInfoList.first?.timePoint ?? 0
        let last = barrageInfoList.last?.timePoint ?? 0
          
        // timeStart: 视频播放时间, allStart: 第一条弹幕时间, last: 最后一条弹幕时间
        if timeStart + timeLength < allStart || last < timeStart {
            // 时间范围在所有弹幕时间范围之外，没有弹幕
            return nil
        }
          
        // 弹幕匀速播放, timeStart 开始重 searchIndex 弹幕位置放
        var searchIndex: Int = 0
        if timeStart > allStart {
            searchIndex = Int((timeStart - allStart) / (last - allStart) * CGFloat(barrageInfoList.count))
            if searchIndex >= barrageInfoList.count {
                searchIndex = barrageInfoList.count - 1
            }
        }
          
        // 修正播放timeStart开始播放的弹幕
        var barrageType: AnAnBarrageInfo? = barrageInfoList[searchIndex]
        while barrageType?.timePoint ?? 0 >= timeStart && searchIndex > 0 {
            barrageType = barrageInfoList[searchIndex - 1]
            searchIndex -= 1
        }
        while barrageType?.timePoint ?? 0 < timeStart && searchIndex < barrageInfoList.count - 1 {
            barrageType = barrageInfoList[searchIndex + 1]
            searchIndex += 1
        }
          
        var array: [AnAnBarrageInfo] = []
        for index in searchIndex..<barrageInfoList.count {
            barrageType = barrageInfoList[index]
            if barrageType?.timePoint ?? 0 < timeStart + timeLength {
                array.append(barrageType!)
            } else {
                break
            }
        }
          
        return array
    }
    
//  发送弹幕
    func sendBarrage() {
        
    }
    
//  开始弹幕
    func startBarrage() {
//        清空已显示弹幕记录，重新开始
        displayedBarrageSet.removeAll()
//        请求弹幕数据
        requestBarrageListData()
        playBarrage()
        createTimer()
        isPlaying = true
        isPauseing = false
    }
//  暂停弹幕
    func pauseBarrage() {
        barrageTime?.fireDate = .distantFuture
            for label in subviews.filter({ $0 is UIButton }) {
                guard let label = label as? UIButton else { continue }
                let layer = label.layer
                var rect = label.frame
                if let presentationLayer = layer.presentation() {
                    rect = presentationLayer.frame
                }
                label.frame = rect
                label.layer.removeAllAnimations()
            }
            isPauseing = true
            isPlaying = false
    }
//  继续弹幕
    func resumeBarrage() {
        print("barrageViewDebug: resume")
        guard isPrepared && !isPlaying else {
            print("barrageViewDebug: resume doing nothing")
            return
        }
      
        DispatchQueue.main.async {
            self.subBarrageInfoList.forEach { info in
                self.performAnimationWithDuration(duration: info.timerMargin ?? 0, info: info)
                
            }
        }
      
        let timeMarginSeconds = Double(timeMargin) // 假设timeMargin是一个TimeInterval或者可以转换为TimeInterval的类型
        let delayTime = DispatchTime.now() + timeMarginSeconds
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.barrageTime?.fireDate = .distantPast
        }
        
    }
//  停止弹幕
    func stopBarrage() {
        cancelTimer()
        // 清除所有弹幕视图
        subviews.forEach { view in
            if view is AnAnBarrageBtn {
                view.removeFromSuperview()
            }
        }
        subBarrageInfoList.removeAll()
        lineDict.removeAll()
        displayedBarrageSet.removeAll()
        isPlaying = false
        isPauseing = false
    }
//  清除弹幕
    func clearBarrage() {
        // 清除所有弹幕视图
        subviews.forEach { view in
            if view is AnAnBarrageBtn {
                view.removeFromSuperview()
            }
        }
        subBarrageInfoList.removeAll()
        lineDict.removeAll()
        displayedBarrageSet.removeAll()
    }
//  播放弹幕
    func playBarrage() {
//        没有准备好，或者已经在播放弹幕
        if isPrepared == false || isPlaying == true {
            return
        }
        
        DispatchQueue.main.async {
            self.barrageInfoList.forEach { model in
                self.performAnimationWithDuration(duration: model.timerMargin ?? 0, info: model)
            }
        }
        let delayTime = DispatchTime.now() + timeMargin*Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.barrageTime?.fireDate = Date.distantPast
        }
        
    }
//    弹幕播放动画
    func performAnimationWithDuration(duration:TimeInterval,info:AnAnBarrageInfo) {
        guard let label = info.barrageBtn else {return}
        
        let endFrame = CGRect(x: -(label.frame.size.width), y: label.frame.origin.y, width: label.frame.size.width, height: label.frame.size.height)
        
//        if ([label.layer.animationKeys].count != 0) {
//            print("====>\(label.layer.animationKeys)")
//            //已经在运行动画了
//            return;
//        }
        
        UIView.animate(withDuration: duration, delay: 0,options: .curveLinear) {
            label.frame = endFrame
        }completion: { finished in
            if finished {
                label.removeFromSuperview()
                
//                销毁已经动画结束的弹幕，在弹幕轨道上创建新的弹幕
                self.subBarrageInfoList.removeAll { subinfo in
                    return subinfo.barrageId == info.barrageId
                }
                
                // 从轨道字典中移除，释放轨道
                let lineCount = info.lineCount
                if self.lineDict[lineCount]?.barrageId == info.barrageId {
                    self.lineDict.removeValue(forKey: lineCount)
                }
                
                // 从已显示集合中移除（可选，如果希望同一弹幕可以重复显示）
                // 这里不移除，确保同一弹幕只显示一次
            }
        }
    }
    
//    弹幕碰撞检测，防止弹幕重叠在一起
    func judgeIsRunintoWithFirstDanmakuInfo(info:AnAnBarrageInfo?,lastInfo:AnAnBarrageInfo?) -> Bool {
        if info?.barrageBtn == nil {
            return false
        }
        guard let firstContent = info?.barrageContent?.string else { return true}
        guard let lastContent = lastInfo?.barrageContent?.string else { return true}
        
        // 所有弹幕速度一致，使用固定速度
        let speed = barragePlaySpeed(w: 0)
        let firstRight = (info?.timerMargin ?? 0) * speed

        if (info?.timerMargin ?? 0) <= 1 {
            return false
        }
        
        // 计算前一个弹幕的当前位置
        let firstCurrentX = self.frame.size.width - firstRight
        
        // 两个弹幕之间的间隔
        if firstCurrentX > 20 {
            // 如果前一个弹幕已经移动了足够距离，可以放置新弹幕
            return false
        }
        
        // 如果前一个弹幕还在屏幕右侧，需要检查是否会碰撞
        // 由于所有弹幕速度一致，只需要检查间距是否足够
        let minSpacing: CGFloat = 20 // 最小间距
        if firstCurrentX > minSpacing {
            return false
        }
        
        return true
    }
    
//    计算弹幕速度（固定速度，所有弹幕速度一致）
    func barragePlaySpeed(w:CGFloat) -> CGFloat {
        // 固定速度：屏幕宽度 / duration，不依赖弹幕宽度
        return self.bounds.size.width / duration
    }
    
//    根据弹幕宽度计算实际需要的动画时长（保持速度一致）
    func calculateDurationForWidth(width: CGFloat) -> TimeInterval {
        // 固定速度
        let minWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        let speed = minWidth / duration
        // 根据宽度和速度计算实际需要的时长
        return TimeInterval((minWidth + width) / speed)
    }
    
//    计算文字内容大小
    func calculateStringWidth(string: String, font: UIFont) -> CGFloat {
        // 创建一个包含所需属性的字典
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black  // 可以根据需要设置其他属性，例如颜色
        ]
          
        // 使用 NSString 的 size(withAttributes:) 方法计算字符串的大小
        let size = string.size(withAttributes: attributes)
          
        // 返回宽度
        return size.width+10
    }
}
