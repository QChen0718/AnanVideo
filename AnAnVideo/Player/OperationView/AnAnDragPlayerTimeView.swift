//
//  AnAnDragPlayerTimeView.swift
//  RuanVideo
//
//  Created by 陈庆 on 2023/3/30.
//  拖动提示view

import UIKit

class AnAnDragPlayerTimeView: UIView {

    private lazy var iconImageView:UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.pingFangSemiboldWithSize(fontSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var timeStr:String = ""{
        didSet{
            timeLabel.text = timeStr
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
        layer.cornerRadius = 5
        backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createSubviews() {
        addSubview(iconImageView)
        addSubview(timeLabel)
    }
    
    private func setSubviewsFrame() {
//        iconImageView.snp.makeConstraints { make in
//            make.center
//        }
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
}
