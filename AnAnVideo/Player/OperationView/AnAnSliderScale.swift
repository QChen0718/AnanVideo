//
//  AnAnSliderScale.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/26.
//  带刻度的滑块进度条

import UIKit

class AnAnSliderScale: UIView {

    var sliderChangeBlock:((Float)->Void)?
    
    lazy var scaleView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#FFFFFF",alpha: 0.2)
        return view
    }()
    
    var scaleNumber:Int = 0 {
        didSet{
            self.layoutIfNeeded()
            for i in 0..<scaleNumber {
                if i == 0 {
                    continue
                }
                let view = UIView()
                view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#FFFFFF",alpha: 0.2)
                sliderView.addSubview(view)
                view.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: 1, height: 4))
                    make.centerY.equalToSuperview()
                    make.leading.equalTo(i * (167-4*scaleNumber)/scaleNumber+4*i)
                }
            }
        }
    }
    
    var sliderValue:Float = 0.0 {
        didSet{
            sliderView.value = sliderValue
        }
    }
    
    private lazy var sliderView:AnAnCustomSlider = {
       let slider = AnAnCustomSlider()
        slider.sliderHeight = 4
        slider.isContinuous = true
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.minimumTrackTintColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF)
        slider.maximumTrackTintColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.2)
        slider.setThumbImage(UIImage(named: "slider_huakuai"), for: .normal)
        slider.addTarget(self, action: #selector(sliderValueTouch), for: .touchUpInside)
       
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSliderTap(_:)))
          
        // 将手势识别器添加到 slider 的父视图（通常是 self.view）
        // 注意：这里我们添加到 self.view，实际使用时可能需要根据情况调整
        self.addGestureRecognizer(tapGesture)
        addSubview(sliderView)
        sliderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
  
        if scaleNumber == 0 {
            sliderView.setValue(clampedValue, animated: true)
            sliderChangeBlock?(clampedValue)
        }else{
            // 设置 slider 的 value
            let value2 = clampedValue*10
            var step = roundf(value2/Float(10/scaleNumber))
            step *= Float(10/scaleNumber)
            sliderView.setValue(step/10.0, animated: true)
            sliderChangeBlock?(step/10.0)
        }
        
        // 这里可以获取并处理新的 value
        print("Slider value after tap: \(clampedValue)")
    }
    
    @objc func sliderValueTouch(sender:UISlider){
        print("value--->\(sender.value)")
        if scaleNumber == 0 {
            sender.setValue(sender.value, animated: true)
            sliderChangeBlock?(sender.value)
        }else{
            let chushu:Int = Int(10/scaleNumber)
            let value = sender.value*10
            var step = roundf(value/Float(10/scaleNumber))
//            step *= Float(10/scaleNumber)
            let newvalue = (1.0/Float(scaleNumber)) * step;
            sender.setValue(newvalue, animated: true)
            sliderChangeBlock?(newvalue)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
