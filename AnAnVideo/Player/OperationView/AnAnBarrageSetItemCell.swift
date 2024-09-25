//
//  AnAnBarrageSetItemCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/24.
//

import UIKit

class AnAnBarrageSetItemCell: UITableViewCell {

   private lazy var titleLab:UILabel = {
       let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_E5E7EB,alpha: 0.6)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        lab.text = "显示区域"
        return lab
    }()
    
    private lazy var sliderView:AnAnCustomSlider = {
       let slider = AnAnCustomSlider()
        slider.sliderHeight = 4
        slider.isContinuous = true
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.minimumTrackTintColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF)
        slider.maximumTrackTintColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.2)
        slider.setThumbImage(UIImage(named: "slider_huakuai"), for: .normal)
        slider.addTarget(self, action: #selector(sliderValueDidChanged), for: .editingDidEnd)
        slider.addTarget(self, action: #selector(sliderValueTouch), for: .touchUpInside)
        return slider
    }()
    
    private lazy var typeLab:UILabel = {
        let lab = UILabel()
        lab.text = "50%"
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_E5E7EB,alpha: 0.6)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(titleLab)
        contentView.addSubview(sliderView)
        contentView.addSubview(typeLab)
        titleLab.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(10)
        }
        
        sliderView.snp.makeConstraints { make in
            make.leading.equalTo(3)
            make.trailing.equalTo(typeLab.snp.leading).offset(-6)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.height.equalTo(15)
        }
        
        typeLab.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(sliderView)
            make.width.equalTo(35)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sliderValueDidChanged(sender:UISlider){
        print("value--->\(sender.value)")
        let value = sender.value*10
        var step = roundf(value/2.0)
        step *= 2
        sender.setValue(step/10.0, animated: true)
    }
    
    @objc func sliderValueTouch(sender:UISlider){
        print("value--->\(sender.value)")
        let value = sender.value*10
        var step = roundf(value/2.0)
        step *= 2
        sender.setValue(step/10.0, animated: true)
    }
}
