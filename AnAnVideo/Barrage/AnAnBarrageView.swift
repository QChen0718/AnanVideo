//
//  AnAnBarrageView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/26.
//  弹幕视图

import UIKit

class AnAnBarrageView: UIView {
//  发送弹幕
    func sendBarrage() {
        
    }
    
    private func createTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getPlayTimeBarrageData), userInfo: nil, repeats: true)
        
    }
    
    private func cancelTimer() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red.withAlphaComponent(0.5)
//        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.5)
        
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
    
    
//    获取播放时间段弹幕
    @objc func getPlayTimeBarrageData(){
        
    }
    
}
