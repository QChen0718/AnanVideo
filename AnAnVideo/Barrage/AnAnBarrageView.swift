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
    var duration:CGFloat = 20
//    弹幕弹道高度
    var lineHeight:CGFloat = 20
//    弹幕弹道之间的间距
    var lineMargin:CGFloat = 5
//    弹幕弹道最大行数
    var maxShowLineCount:Int = 10
//    时间间隔
    let timeMargin:TimeInterval = 0.08
//    当前播放器
    var playerManagerView:AnAnVideoPlayerManager?
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
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.5)
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
                modelList.forEach { model in
                    let paramsArray = model?.p?.components(separatedBy: ",")
                    let barrageInfo = AnAnBarrageInfo()
                    barrageInfo.barrageId = paramsArray?[7]
                    barrageInfo.timePoint = TimeInterval(paramsArray?.first ?? "")
                    barrageInfo.barrageColor = paramsArray?[3] ?? ""
                    barrageInfo.barrageContent = NSMutableAttributedString(string: model?.d ?? "")
                    barrageInfo.barrageCover = model?.a
                    curInfoList.append(barrageInfo)
                }
                DispatchQueue.main.async {
                    self.barrageInfoList = curInfoList
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
        guard var barrageArray = getBarrages(withTimeStart: playerManagerView?.currentPlayerTime ?? 0, timeLength: timeMargin*5) else {return}
//        存在弹幕
        if !barrageArray.isEmpty {
//            移除当前获取的弹幕数组中已经展示的弹幕，创建未展示的弹幕数据
            let showBarrages = getCurrentShowBarrages()
            showBarrages.forEach { barrageInfo in
                barrageArray.removeAll { curInfo in
                    barrageInfo.barrageId == curInfo.barrageId
                }
            }
            for i in 0..<barrageArray.count {
//                创建弹幕lable展示弹幕
                createBarrage(barInfo: barrageArray[i],i: CGFloat(i))
            }
        }
//        print("===>弹幕数\(barrageArray.count)")
    }
//    创建弹幕
    func createBarrage(barInfo:AnAnBarrageInfo,i:CGFloat) {
        let btn = AnAnBarrageBtn(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        btn.setAttributedTitle(barInfo.barrageContent, for: .normal)
        self.addSubview(btn)
//        btn.frame = CGRectMake(AnAnAppDevice.an_screenWidth(), 40, 100, 30)
        
        barInfo.barrageBtn = btn
        barInfo.timerMargin = self.duration
        
//        for i in 0..<self.maxShowLineCount {
        barInfo.lineCount = Int(i)
        barInfo.barrageBtn?.frame = CGRect(x: self.frame.width, y: (self.lineHeight + self.lineMargin) * i + 44 , width: calculateStringWidth(string: barInfo.barrageContent?.string ?? "",font: .systemFont(ofSize: 15, weight: .regular)), height: 30)
            self.performAnimationWithDuration(duration: barInfo.timerMargin ?? 0, info: barInfo)
//        }
        
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
//        请求弹幕数据
        requestBarrageListData()
        playBarrage()
        createTimer()
        isPlaying = true
        isPauseing = false
    }
//  暂停弹幕
    func pauseBarrage() {
        
    }
//  继续弹幕
    func resumeBarrage() {
        
    }
//  停止弹幕
    func stopBarrage() {
        
    }
//  清除弹幕
    func clearBarrage() {
        
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
        
//        if label.layer.animationKeys()?.count != 0 {
////            已经在运行动画了
//            return
//        }
        UIView.animate(withDuration: duration, delay: 0,options: .curveLinear) {
            label.frame = endFrame
        }completion: { finished in
            if finished {
                label.removeFromSuperview()
                self.barrageInfoList.removeAll { model in
                    return model.barrageId == info.barrageId
                }
            }
        }
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
        return size.width
    }
}
