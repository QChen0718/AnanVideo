//
//  AnAnluminanceView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/22.
//  调节屏幕亮度

import UIKit

class AnAnluminanceView: UIView {
    lazy var progressView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF ,alpha: 0.8)
        return view
    }()
    
    lazy var brightnessIcon:UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_voice0"))
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000, alpha: 0.3)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(progressView)
        addSubview(brightnessIcon)
        progressView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0)
            make.leading.equalToSuperview()
        }
        brightnessIcon.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
    }
    
    var brightnessValue:CGFloat?{
        didSet{
            progressView.snp.updateConstraints { make in
                make.width.equalTo((brightnessValue ?? 0) * self.frame.width)
            }
            brightnessImg(value: brightnessValue)
        }
    }
    
    private func brightnessImg(value:CGFloat?) {
        guard let volume = value else { return }
        switch volume {
        case 0:
            brightnessIcon.image = UIImage(named: "ic_brightness1")
            break
        case 0.01...0.25:
            brightnessIcon.image = UIImage(named: "ic_brightness2")
            break
        case 0.26...0.5:
            brightnessIcon.image = UIImage(named: "ic_brightness3")
            break
        case 0.51...0.75:
            brightnessIcon.image = UIImage(named: "ic_brightness4")
            break
        case 0.76...1.0:
            brightnessIcon.image = UIImage(named: "ic_brightness5")
            break
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
