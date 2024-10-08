//
//  AnAnBarrageView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/26.
//  弹幕视图

import UIKit

class AnAnBarrageView: UIView {
    var barrageTime:Timer?
//    弹幕数据
    var barrageDataList:[AnAnBarrageDataModel] = []
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
        
        AnAnRequest.shared.requestCDNBarrageData(episodeId:videoDetail?.watchInfo?.m3u8?.episodeSid ?? "") { model in
            
        }
    }
        
    private func createTimer() {
        if barrageTime == nil {
            let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getPlayTimeBarrageData), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            barrageTime = timer
        }
    }
    
    private func cancelTimer() {
        barrageTime?.invalidate()
    }
    
//    获取播放时间段弹幕
    @objc func getPlayTimeBarrageData(){
        
    }
    
//  发送弹幕
    func sendBarrage() {
        
    }
    
//  开始弹幕
    func startBarrage() {
//        请求弹幕数据
        requestBarrageListData()
        
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
            self.barrageDataList.forEach { model in
                
            }
        }
        let delayTime = DispatchTime.now() + timeMargin*Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.barrageTime?.fireDate = Date.distantPast
        }
        
    }
//    弹幕播放动画
    func performAnimationWithDuration(duration:TimeInterval) {
        
    }
}
