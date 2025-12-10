//
//  AnAnVideoPlayerManager.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/23.
//

import UIKit
import AVFoundation

enum PlayerStatus:Int {
    case PlayerStatusReadyToPlay //开始播放
    case PlayerStatusEndPlay     //播放结束
    case PlayerStatusFailed      //播放出错
}
typealias AnAnPlayerStatusBlock = (PlayerStatus)->Void

typealias PlayerStatusBlock = (AVPlayerItem.Status)->Void
// 播放结束
typealias PlayerDidEndBlock = ()->Void

class AnAnVideoPlayerManager: UIView {
//  视频播放
    private var player:AVPlayer?
//  媒资管理对象
    private var playerItem:AVPlayerItem?
//  显示视频视图层
    private var playerLayer:AVPlayerLayer?
    
    var playerStatusBlock:PlayerStatusBlock?
    
    var playerDidEndBlock:PlayerDidEndBlock?
    
    var ananPlayerStatusBlock:AnAnPlayerStatusBlock?
    
    init(playerUrl:String,isPlayerLocationFile:Bool = false) {
        super.init(frame: .zero)
        setupAudioSessionForBackgroundPlayback()
//        播放网络地址文件
        if isPlayerLocationFile {
            //        播放本地文件
            let str = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            if #available(iOS 16.0, *) {
                playerItem = AVPlayerItem(url: URL(filePath: "\(str)/41e1f3f7e0c04d60b242c996b6405bbf-428af4f36abea18c8c418548243aba2a-ld.mp4"))
            } else {
                // Fallback on earlier versions
                playerItem = AVPlayerItem(url: URL(fileURLWithPath: "\(str)/41e1f3f7e0c04d60b242c996b6405bbf-428af4f36abea18c8c418548243aba2a-ld.mp4"))
            }
        }else {
            playerItem = AVPlayerItem(url: URL(string: playerUrl)!)
        }
        
        player = AVPlayer.init(playerItem: playerItem)
        player?.rate = 0.0 //设置播放速率
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspect
        
        createSubviews()

//        添加播放状态监听
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
//        添加监听播放结束
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
    }
    
    private func setupAudioSessionForBackgroundPlayback() {
            do {
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(.playback, mode: .moviePlayback, options: [])
                try session.setActive(true)
            } catch {
                print("音频会话设置失败: \(error)")
            }
        }
    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer = AVPlayerLayer.init(player: player)
        playerLayer?.videoGravity = .resizeAspect
        createSubviews()
    }
    
//    设置播放URL
    func currentUrl(url:String) {
        if (url.isEmpty) {
            return
        }
        //创建媒体资源管理对象
        self.playerItem = AVPlayerItem(url: URL(string: url)!)
        self.playerItem?.addObserver(self, forKeyPath: "status", options: [.initial, .new], context: nil)
        self.player = AVPlayer.init(playerItem: self.playerItem)
        self.player?.rate = 0.0
        
        self.playerLayer?.player = self.player
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        guard let `playerLayer` = playerLayer else { return }
        layer.addSublayer(playerLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//    动态更新playerlayer视图大小
        playerLayer?.frame = self.bounds
    }
//    判断是否在播放
    var playerStatus:AVPlayer.TimeControlStatus?{
        return player?.timeControlStatus
    }
    
    var isPlaying:Bool{
        if playerStatus == .playing{
            return true
        }else{
            return false
        }
    }
//    播放速率
    var playerRate:Float?{
        set{
            player?.rate = newValue ?? 1.0
        }get{
            return player?.rate
        }
        
    }

//    当前播放时间
    var currentPlayerTime:Double?{
        return playerItem?.currentTime().seconds
    }
//    总播放时间
    var totalPlayerTime:CMTime?{
        return playerItem?.duration
    }
//    播放到指定位置
    var seekToPlayerLocation:Float = 0.0 {
        didSet{
            player?.seek(to: CMTime(value: CMTimeValue(seekToPlayerLocation), timescale: 1), completionHandler: { _ in
                
            })
        }
    }
//    当前播放时间格式化
    var currentTimeString:String{
        if (player != nil) {
            if let playBackTime = currentPlayerTime{
                let timerStr = String(format: "%f", playBackTime)
                return timerStr.playerTimerFormat()
            }
        }
        return "00:00:00"
    }
    
//    总播放时间格式化
    var totalTimerString:String{
        if player != nil {
            if let playDuration = totalPlayerTime{
                let totalSeconds = CMTimeGetSeconds(playDuration)
                if totalSeconds.isNaN || totalSeconds.isInfinite {
                    return "00:00:00"
                }
                let timerStr = String(format: "%f", totalSeconds)
                return timerStr.playerTimerFormat()
            }
        }
        return "00:00:00"
    }
//    开始播放
    func startPlayer() {
        player?.play()
    }
//    暂停播放
    func pausePlayer() {
        player?.pause()
    }
//    结束播放
    func stopPlayer() {
        playerItem?.removeObserver(self, forKeyPath: "status")
        player?.pause()
        player = nil
        playerItem = nil
        playerLayer = nil
    }
    deinit {
        print("播放器视图销毁")
        stopPlayer()
        NotificationCenter.default.removeObserver(self)
    }
}

extension AnAnVideoPlayerManager{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            guard let `playerItem` = playerItem else { return }
            playerStatusBlock?(playerItem.status)
            switch playerItem.status{
            case .readyToPlay:
                //准备播放
//                player?.play()
                break
            case .failed:
                //播放失败
                print("failed")
            case.unknown:
                //未知情况
                print("unkonwn")
            @unknown default:
                break
            }
        }
    }
//    播放结束监听
    @objc func playerDidFinishPlaying(note: NSNotification){
        print("Video Finished")
        playerDidEndBlock?()
    }
}

extension CMTime {
    /// 返回安全的秒数（对 invalid/indefinite 给 0）
    var safeSeconds: Double {
        let s = CMTimeGetSeconds(self)
        if s.isFinite && s >= 0 {
            return s
        } else {
            return 0
        }
    }
}
