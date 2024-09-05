//
//  AnAnTableSectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/28.
//

import UIKit

class AnAnTableSectionView: UIView {
    lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.hexadecimalColor(hexadecimal: An_000000)
        label.font = UIFont.pingFangSemiboldWithSize(fontSize: 20)
        return label
    }()
    lazy var refreshBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ic_home_refresh"), for: .normal)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    func createSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(refreshBtn)
    }
    func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.height.equalTo(24)
            make.top.equalToSuperview()
            make.trailing.equalTo(refreshBtn.snp.leading).offset(-10)
        }
        refreshBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(-20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
