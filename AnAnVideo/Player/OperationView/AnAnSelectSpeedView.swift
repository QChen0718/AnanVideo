//
//  AnAnSelectSpeedView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/16.
//

import UIKit

class AnAnSelectSpeedView: UIView {

    lazy var epBgview:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#000000", alpha: 0.85)
        return view
    }()
    
    //    选择清晰度
    private lazy var speedTableview:AnAnSpeedTableView = {
        let tableView = AnAnSpeedTableView(frame: .zero, style: .plain)
        tableView.currentSpeedBlock = {[weak self] value in
            guard let `self` else {return}
            self.currentSpeedBlock?(value)
        }
        return tableView
    }()

    var currentSpeedBlock:CurrentSelectSpeedBlock?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(epBgview)
        epBgview.addSubview(speedTableview)
    }
    
    private func setSubviewsFrame() {
        let height = min(AnAnAppDevice.an_screenWidth(), AnAnAppDevice.an_screenHeight())
        epBgview.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(270)
            make.width.equalTo(270)
        }
        
        speedTableview.snp.makeConstraints { make in
            make.trailing.width.equalToSuperview()
            make.height.equalTo(64*5)
            make.top.equalTo((height-64*5)/2)
        }
    }
    
    func showSelectSpeedView(){
        self.layoutIfNeeded()
        self.epBgview.snp.updateConstraints { make in
            make.trailing.equalToSuperview()
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let `self` else {return}
            
            self.layoutIfNeeded()
        }
    }
    
    func hiddenSelectSpeedView() {
        self.epBgview.snp.updateConstraints { make in
            make.trailing.equalTo(270)
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let `self` else {return}
            self.layoutIfNeeded()
        } completion: { success in
            if success {
                self.removeFromSuperview()
            }
        }

    }
}
