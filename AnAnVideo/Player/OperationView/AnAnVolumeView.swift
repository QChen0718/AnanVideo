//
//  AnAnVolumeView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/22.
//  调节音量

import UIKit

class AnAnVolumeView: UIView {
    
    lazy var progressView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF ,alpha: 0.8)
        return view
    }()
    
    lazy var volumeIcon:UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_voice0"))
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000, alpha: 0.3)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(progressView)
        addSubview(volumeIcon)
        progressView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0)
            make.leading.equalToSuperview()
        }
        volumeIcon.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
    }
    
    var volumeValue:Float?{
        didSet{
            progressView.snp.updateConstraints { make in
                make.width.equalTo(CGFloat(volumeValue ?? 0) * self.frame.width)
            }
            volumeImg(value: volumeValue)
        }
    }
    
    private func volumeImg(value:Float?) {
        guard let volume = value else { return }
        switch volume {
        case 0:
            volumeIcon.image = UIImage(named: "ic_voice0")
            break
        case 0.01...0.3:
            volumeIcon.image = UIImage(named: "ic_voice1")
            break
        case 0.31...0.6:
            volumeIcon.image = UIImage(named: "ic_voice2")
            break
        case 0.61...1.0:
            volumeIcon.image = UIImage(named: "ic_voice3")
            break
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
