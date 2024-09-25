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
//        slider.addTarget(self, action: #selector(sliderValueDidChanged), for: .editingDidEnd)
        slider.addTarget(self, action: #selector(sliderValueTouch), for: .touchUpInside)
        return slider
    }()
    
    private lazy var typeLab:UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_E5E7EB,alpha: 0.6)
        lab.font = .systemFont(ofSize: 12, weight: .regular)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSliderTap(_:)))
          
        // 将手势识别器添加到 slider 的父视图（通常是 self.view）
        // 注意：这里我们添加到 self.view，实际使用时可能需要根据情况调整
        contentView.addGestureRecognizer(tapGesture)
        contentView.addSubview(titleLab)
        contentView.addSubview(sliderView)
        contentView.addSubview(typeLab)
        titleLab.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(10)
        }
        
        sliderView.snp.makeConstraints { make in
            make.leading.equalTo(3)
            make.trailing.equalTo(typeLab.snp.leading).offset(-8)
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
        var step = roundf(value/2.5)
        step *= 2.5
        sender.setValue(step/10.0, animated: true)
        updateTypeValue(type: barrageSetModel?.setType, value: step/10.0)
    }
    
    @objc func handleSliderTap(_ gesture: UITapGestureRecognizer) {
        // 将点击位置从 gesture 的视图坐标系转换到 slider 的坐标系
        let pointInSlider = gesture.location(in: sliderView)
  
        // 假设 slider 是水平的（如果它是垂直的，你需要相应地调整逻辑）
        let width = sliderView.bounds.size.width
        let minValue = sliderView.minimumValue
        let maxValue = sliderView.maximumValue
        let range = maxValue - minValue
  
        // 计算点击位置对应的 value
        let value = minValue + Float((pointInSlider.x / width)) * range
  
        // 确保 value 在 slider 的允许范围内
        let clampedValue = max(minValue, min(value, maxValue))
  
        // 设置 slider 的 value
        sliderView.value = clampedValue
  
        // 这里可以获取并处理新的 value
        print("Slider value after tap: \(clampedValue)")
    }
    
    var barrageSetModel:AnAnBarrageModel? {
        didSet{
            titleLab.text = barrageSetModel?.setName
            sliderView.value = barrageSetModel?.value ?? 0.0
            updateTypeValue(type: barrageSetModel?.setType, value: barrageSetModel?.value ?? 0.0)
        }
    }
    
    func updateTypeValue(type:BarrageSetType?,value:Float)  {
        switch type {
        case .BarrageSetTypeArea:
            typeLab.text = "50%"
            break
        case .BarrageSetTypeAlpha:
            typeLab.text = "100%"
            break
        case .BarrageSetTypeFont:
            typeLab.text = "标准"
            break
        case .BarrageSetTypeSpeed:
            typeLab.text = "最慢"
            break
        default:
            break
        }
    }
}
