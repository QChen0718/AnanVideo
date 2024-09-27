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
        slider.sliderChangeBlock = {[weak self] value,str in
            guard let `self` else {return}
            self.typeLab.text = str
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
    
    var barrageSetModel:AnAnBarrageModel? {
        didSet{
            titleLab.text = barrageSetModel?.setName
            sliderView.sliderValue = barrageSetModel?.value ?? 0.0
            typeLab.text = barrageSetModel?.valueName
            switch barrageSetModel?.setType {
            case .BarrageSetTypeArea:
                sliderView.scaleNumber = 3
                sliderView.valueList = ["25%","50%","75%","100%"]
                break
            case .BarrageSetTypeAlpha:
                sliderView.scaleNumber = 0
                break
            case .BarrageSetTypeFont:
                sliderView.scaleNumber = 4
                sliderView.valueList = ["特小","小","标准","大","特大"]
                break
            case .BarrageSetTypeSpeed:
                sliderView.scaleNumber = 4
                sliderView.valueList = ["最慢","慢","标准","快","特快"]
                break
            default:
                break
            }
        }
    }
}
