//
//  AnAnPlayerBottomView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/21.
//  底部操作view

import UIKit

typealias SelectBtnBlock = (UIButton)->Void
typealias CloseHiddenOperationTimeBlock = (Bool)->Void

class AnAnPlayerBottomView: UIView {

    var closeTimeBlock:CloseHiddenOperationTimeBlock?
    var playerManagerView:AnAnVideoPlayerManager?{
        didSet{
            if let playerRate = playerManagerView?.playerStatus{
                if playerRate == .paused {
//                    暂停播放
                    playerIconBtn.isSelected = false
                }else {
//                    正在播放
                    playerIconBtn.isSelected = true
                }
            }
            playerStartTimeLabel.text = playerManagerView?.currentTimeString
            playerEndTimeLabel.text = playerManagerView?.totalTimerString
            if let totalValue = playerManagerView?.totalPlayerTime?.value {
                playerProgressSlider.maximumValue = Float(totalValue/1000)
            }
            playerManagerView?.ananPlayerStatusBlock = {[weak self] status in
                guard let `self` else { return  }
                if status == .PlayerStatusReadyToPlay {
//                  开始播放，开启定时器
                    self.initTimer()
                }else if status == .PlayerStatusEndPlay{
//                  播放结束通知回调结束定时器
                    self.playerIconBtn.setImage(UIImage(named: "ic_video_continue"), for: .normal)
                    self.cancelTimer()
                }
            }
        }
    }
    
//    更新按钮状态
    var updateBtnStatus:Bool = false{
        didSet{
            playerIconBtn.isSelected = updateBtnStatus
        }
    }
    
    //    是否隐藏下一集按钮
    var isHiddenNextBtn:Bool = false{
        didSet{
            let orientation = UIApplication.shared.statusBarOrientation
            if orientation == .portrait {
                nextPlayerBtn.isHidden = true
            }else{
                nextPlayerBtn.isHidden = isHiddenNextBtn
            }
        }
    }
    
    var selectBtnBlock:SelectBtnBlock?
    
    private lazy var playerIconBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_video_continue"), for: .normal)
        btn.setImage(UIImage(named: "ic_player"), for: .selected)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var playerStartTimeLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"00:00:00",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 10))
        label.textAlignment = .center
        label.alpha = 0.6
        return label
    }()
    
    private lazy var playerProgressSlider:AnAnCustomSlider = {
        let slider = AnAnCustomSlider()
        slider.isContinuous = true
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.minimumTrackTintColor = UIColor.hexadecimalColor(hexadecimal: An_F75C94)
        slider.maximumTrackTintColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.4)
        
        slider.setThumbImage(UIImage(named: "slider_circle_fill"), for: .normal)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchInside), for: .touchUpInside)
        
        return slider
    }()
    
    private lazy var playerEndTimeLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"00:00:00",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 10))
        label.textAlignment = .center
        label.alpha = 0.6
        return label
    }()
    
    private lazy var nextPlayerBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_video_next"),target: self,action: #selector(nextBtnClick))
        btn.tag = 100
        return btn
    }()
    
    private lazy var fullScreenBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "icon_videoplayer_fullscreen"),target: self,action: #selector(fullScreenClick))
        btn.tag = 200
        return btn
    }()
    
    private var updateTimeAndSlider:Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createSubviews()
        setSubviewsFrame()
        orientationUpdateViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initTimer(){
        updateTimeAndSlider = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] timer in
            guard let `self` = self else { return }
            self.updateSilderAndTime()
        })
        if let progressTimer = updateTimeAndSlider{
            RunLoop.main.add(progressTimer, forMode: .common)
        }
    }
    
    private func updateSilderAndTime(){
        if let currentTimeString = playerManagerView?.currentTimeString{
            playerStartTimeLabel.text = currentTimeString
        }
        if let value = playerManagerView?.currentPlayerTime{
            playerProgressSlider.setValue(Float(value), animated: true)
        }
    }
    
//    屏幕旋转,更新控件大小
    func orientationUpdateViews(){
        let orientation = UIApplication.shared.statusBarOrientation
        switch orientation {
        case .landscapeLeft,.landscapeRight:
            fullScreenBtn.isHidden = true
            nextPlayerBtn.isHidden = false
            playerIconBtn.snp.updateConstraints { make in
                make.leading.equalTo(30)
            }
            playerEndTimeLabel.snp.remakeConstraints { make in
                make.leading.equalTo(playerProgressSlider.snp.trailing).offset(15)
                make.centerY.equalTo(playerIconBtn)
                make.trailing.equalTo(nextPlayerBtn.snp.leading).offset(-10)
                make.height.equalTo(10)
            }
            break
        case .portrait:
            fullScreenBtn.isHidden = false
            nextPlayerBtn.isHidden = true
            playerIconBtn.snp.updateConstraints { make in
                make.leading.equalToSuperview()
            }
            playerEndTimeLabel.snp.remakeConstraints { make in
                make.leading.equalTo(playerProgressSlider.snp.trailing).offset(15)
                make.centerY.equalTo(playerIconBtn)
                make.trailing.equalTo(fullScreenBtn.snp.leading).offset(-10)
                make.height.equalTo(10)
            }
            break
        default:
            break
        }
    }
    
    private func createSubviews() {
        addSubview(playerIconBtn)
        addSubview(playerStartTimeLabel)
        addSubview(playerProgressSlider)
        addSubview(playerEndTimeLabel)
        addSubview(nextPlayerBtn)
        addSubview(fullScreenBtn)
    }
    
    private func setSubviewsFrame() {
        playerIconBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(45)
        }
        
        playerStartTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerIconBtn.snp.trailing).offset(10)
            make.trailing.equalTo(playerProgressSlider.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(10)
        }
        
        playerProgressSlider.snp.makeConstraints { make in
            make.leading.equalTo(playerStartTimeLabel.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playerEndTimeLabel.snp.leading).offset(-10)
            make.height.equalTo(2.5)
        }
        
        playerEndTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerProgressSlider.snp.trailing).offset(15)
            make.centerY.equalTo(playerIconBtn)
            make.trailing.equalTo(fullScreenBtn.snp.leading).offset(-10)
            make.height.equalTo(10)
        }
        
        nextPlayerBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-30)
            make.centerY.equalToSuperview()
            make.size.equalTo(45)
        }
        
        fullScreenBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(45)
        }
    }
//    拖动更新进度条，时间
    func dragUpdateProgressTimeLabel(timeStr:String,time:Float) {
        playerStartTimeLabel.text = timeStr
        playerProgressSlider.setValue(time, animated: true)
        playerManagerView?.seekToPlayerLocation = time
    }

    //    开始下一集时开启定时器
    func openProgressAndTime() {
        updateSilderAndTime()
    }
//  移除之前的定时器
    func closeProgressAndTime() {
        cancelTimer()
    }
    
//    滑动滑块
    @objc private func sliderValueChanged(slider:UISlider){
        //    关闭消失操作栏定时器
        closeTimeBlock!(true)
        cancelTimer()
        playerStartTimeLabel.text = String(format: "%.f", slider.value).playerTimerFormat()
        playerManagerView?.seekToPlayerLocation = slider.value
    }
//    点击滑块
    @objc private func sliderTouchInside(slider:UISlider){
        //    开启消失操作栏定时器
        closeTimeBlock!(false)
        initTimer()
    }
    
    @objc fileprivate func fullScreenClick(){

        selectBtnBlock!(fullScreenBtn)
    }
    
    @objc fileprivate func nextBtnClick(){
        selectBtnBlock!(nextPlayerBtn)
    }
    
    @objc private func btnClick(){
        if playerIconBtn.isSelected {
//            暂停
            playerManagerView?.pausePlayer()
        }else{
//            播放
            playerManagerView?.startPlayer()
        }
        playerIconBtn.isSelected = !playerIconBtn.isSelected
    }
    
    deinit {
        print("底部操作视图销毁")
    }
//    关闭定时器
    private func cancelTimer(){
        if updateTimeAndSlider != nil {
            updateTimeAndSlider?.invalidate()
            updateTimeAndSlider = nil
        }
    }
}
