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
    
    private lazy var sliderView:AnAnSliderScale = {
       let slider = AnAnSliderScale()
        slider.sliderChangeBlock = {[weak self] value in
            guard let `self` else {return}
            self.updateTypeValue(type: barrageSetModel?.setType, value: value)
        }
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
        contentView.addSubview(titleLab)
        contentView.addSubview(sliderView)
        contentView.addSubview(typeLab)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sliderView.layoutIfNeeded()
        print("width--->\(sliderView.frame.width)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    @objc func sliderValueTouch(sender:UISlider){
//        print("value--->\(sender.value)")
//        let value = sender.value*10
//        var step = roundf(value/2.5)
//        step *= 2.5
//        sender.setValue(step/10.0, animated: true)
//        updateTypeValue(type: barrageSetModel?.setType, value: step/10.0)
//    }
    
    var barrageSetModel:AnAnBarrageModel? {
        didSet{
            titleLab.text = barrageSetModel?.setName
            sliderView.sliderValue = barrageSetModel?.value ?? 0.0
            updateTypeValue(type: barrageSetModel?.setType, value: barrageSetModel?.value ?? 0.0)
            switch barrageSetModel?.setType {
            case .BarrageSetTypeArea:
                sliderView.scaleNumber = 3
                break
            case .BarrageSetTypeAlpha:
                sliderView.scaleNumber = 0
                break
            case .BarrageSetTypeFont:
                sliderView.scaleNumber = 4
                break
            case .BarrageSetTypeSpeed:
                sliderView.scaleNumber = 4
                break
            default:
                break
            }
        }
    }
    
    func updateTypeValue(type:BarrageSetType?,value:Float)  {
        switch type {
        case .BarrageSetTypeArea:
            typeLab.text = valueToStr(value: value)
            
            break
        case .BarrageSetTypeAlpha:
            typeLab.text = valueToStr(value: value)
            
            break
        case .BarrageSetTypeFont:
//            特小，小，标准，大，特大
            typeLab.text = "标准"
            
            break
        case .BarrageSetTypeSpeed:
//            最慢，慢，标准，快，特快
            typeLab.text = "最慢"
            
            break
        default:
            break
        }
    }
    
    func valueToStr(value:Float) -> String {
        var str = ""
        switch value {
        case 0...0.25:
            str = "25%"
            break
        case 0.26...0.5:
            str = "50%"
            break
        case 0.51...0.75:
            str = "75%"
            break
        case 1.0:
            str = "100%"
            break
        default:
            break
        }
        return str
    }
}
