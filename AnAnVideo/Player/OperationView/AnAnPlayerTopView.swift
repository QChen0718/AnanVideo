//
//  AnAnPlayerTopView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//

import UIKit

typealias BtnSelectBlcok = (UIButton)->Void

class AnAnPlayerTopView: UIView {

    private lazy var backArrowIconBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_arrow_back"), for: .normal)
        btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        btn.tag = 100
        return btn
    }()
    
    private lazy var movieNameLabel:UILabel = {
        let label = UILabel()
        label.text = "怪奇物语 第一季 第1集"
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
        return label
    }()
    
    private lazy var selectEpisodeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("选集", for: .normal)
        btn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 12)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.6)
        btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        btn.layer.cornerRadius = 19
        btn.clipsToBounds = true
        btn.tag = 200
        return btn
    }()
    
    private lazy var selectQualityBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("臻彩", for: .normal)
        btn.titleLabel?.font = UIFont.pingFangSemiboldWithSize(fontSize: 12)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_DBB258), for: .normal)
        btn.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        btn.tag = 300
        return btn
    }()
    
    var selectBtnBlock:BtnSelectBlcok?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createSubviews()
        setSubviewsFrame()
        orientationUpdateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func orientationUpdateViews(){
        let orientation = UIApplication.shared.statusBarOrientation
        switch orientation {
        case .landscapeLeft,.landscapeRight:
            movieNameLabel.isHidden = false
            selectEpisodeBtn.isHidden = false
            selectQualityBtn.isHidden = false
            backArrowIconBtn.snp.updateConstraints { make in
                make.leading.equalTo(30)
            }
            break
        case .portrait:
            movieNameLabel.isHidden = true
            selectEpisodeBtn.isHidden = true
            selectQualityBtn.isHidden = true
            backArrowIconBtn.snp.updateConstraints { make in
                make.leading.equalToSuperview()
            }
            break
        default:
            break
        }
    }
    
    private func createSubviews() {
        addSubview(backArrowIconBtn)
        addSubview(movieNameLabel)
        addSubview(selectEpisodeBtn)
        addSubview(selectQualityBtn)
    }
    
    private func setSubviewsFrame() {
        backArrowIconBtn.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(backArrowIconBtn.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
            make.trailing.equalTo(selectEpisodeBtn.snp.leading).offset(-10)
        }
        selectEpisodeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 38))
            make.trailing.equalTo(selectQualityBtn.snp.leading).offset(-30)
        }
        selectQualityBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 38))
            make.trailing.equalTo(-30)
        }
    }
    var movieName:String = "" {
        didSet{
            movieNameLabel.text = movieName
        }
    }
//    更改清晰度
    var currentQuality:String = "高清"{
        didSet{
            selectQualityBtn.setTitle(currentQuality, for: .normal)
        }
    }
    
    @objc func backClick(btn:UIButton){
        selectBtnBlock!(btn)
    }
}
