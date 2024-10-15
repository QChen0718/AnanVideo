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
    var duration:CGFloat = 2
//    弹幕弹道高度
    var lineHeight:CGFloat = 20
//    弹幕弹道之间的间距
    var lineMargin:CGFloat = 5
//    弹幕弹道最大行数
    var maxShowLineCount:Int = 10
//    时间间隔
    let timeMargin:TimeInterval = 0.08
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
            requestBarrageListData()
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
    }
      
    func getBarrages(withTimeStart timeStart: CGFloat, timeLength: CGFloat) -> [AnAnBarrageType]? {
//        guard let allBarrages = playerDelegate?.playerModel.barrageManager.allBarrages, !allBarrages.isEmpty else {
//            return nil
//        }
//          
//        let allStart = allBarrages.first?.timePoint ?? 0
//        let last = allBarrages.last?.timePoint ?? 0
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
//            searchIndex = Int((timeStart - allStart) / (last - allStart) * CGFloat(allBarrages.count))
//            if searchIndex >= allBarrages.count {
//                searchIndex = allBarrages.count - 1
//            }
//        }
//          
//        // 修正播放timeStart开始播放的弹幕
//        var barrageType: AnAnBarrageType? = allBarrages[searchIndex]
//        while barrageType?.timePoint ?? 0 >= timeStart && searchIndex > 0 {
//            barrageType = allBarrages[searchIndex - 1]
//            searchIndex -= 1
//        }
//        while barrageType?.timePoint ?? 0 < timeStart && searchIndex < allBarrages.count - 1 {
//            barrageType = allBarrages[searchIndex + 1]
//            searchIndex += 1
//        }
          
        var array: [AnAnBarrageType] = []
//        for index in searchIndex..<allBarrages.count {
//            barrageType = allBarrages[index]
//            if barrageType?.timePoint ?? 0 < timeStart + timeLength {
//                array.append(barrageType!)
//            } else {
//                break
//            }
//        }
          
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
        self.insertSubview(label, at: 0)
        if label.layer.animationKeys()?.count != 0 {
//            已经在运行动画了
            return
        }
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
}
