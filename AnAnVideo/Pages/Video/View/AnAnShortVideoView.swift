//
//  AnAnShortVideoView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/22.
//

import UIKit

class AnAnShortVideoView: UIView {
    var playerUrl:String?{
        didSet{
            playerView.currentUrl(url: playerUrl ?? "")
        }
    }
    private lazy var playerView:AnAnVideoPlayerManager = {
        let view = AnAnVideoPlayerManager()
        return view
    }()
    
    func startPlayer() {
        playerView.startPlayer()
    }
    func pausePlayer() {
        playerView.pausePlayer()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playerView)
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
