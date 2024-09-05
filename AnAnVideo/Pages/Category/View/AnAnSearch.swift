//
//  AnAnSearch.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit

class AnAnSearch: UIView {
    
    lazy var searchContent:UILabel = {
        let label = AnAnLabel.createLabel(text: "搜索", fontColor: UIColor.hexadecimalColor(hexadecimal: An_6877AE), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    lazy var searchIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_home_tuijian_search")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        self.addSubview(searchContent)
        self.addSubview(searchIcon)
    }
    
    func setSubviewsFrame() {
        searchContent.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(searchIcon.snp.leading).offset(-19)
            make.height.equalTo(15)
        }
        
        searchIcon.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 13.5, height: 13.5))
        }
    }
}
