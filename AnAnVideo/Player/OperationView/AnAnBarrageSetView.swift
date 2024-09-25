//
//  AnAnBarrageSetView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/24.
//  弹幕设置视图

import UIKit

class AnAnBarrageSetView: UIView {

    private lazy var barrageBgView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_000000,alpha: 0.8)
        return view
    }()
    
    private lazy var barrageSetLab:UILabel = {
       let lab = UILabel()
        lab.text = "弹幕设置"
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_E5E7EB)
        lab.font = .systemFont(ofSize: 15, weight: .semibold)
        return lab
    }()
    
    private lazy var barrageTab:AnAnBarrageTableView = {
        let view = AnAnBarrageTableView(frame: .zero, style: .plain)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(barrageBgView)
        barrageBgView.addSubview(barrageSetLab)
        barrageBgView.addSubview(barrageTab)
        barrageBgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(270)
            make.width.equalTo(270)
        }
        
        barrageSetLab.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.top.equalTo(42)
        }
        
        barrageTab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(barrageSetLab.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    显示
    func showBarrageView(){
        self.layoutIfNeeded()
        self.barrageBgView.snp.updateConstraints { make in
            make.trailing.equalToSuperview()
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let `self` else {return}
            
            self.layoutIfNeeded()
        }
    }
//    隐藏
    func hiddenBarrageView() {
        self.barrageBgView.snp.updateConstraints { make in
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
