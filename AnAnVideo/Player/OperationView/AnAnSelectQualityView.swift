//
//  AnAnSelectQualityView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//  选择画质

import UIKit

class AnAnSelectQualityView: UIView {

    lazy var epBgview:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#000000", alpha: 0.85)
        return view
    }()
    
    //    选择清晰度
    private lazy var qualityTableview:AnAnQualityTableView = {
        let tableView = AnAnQualityTableView(frame: .zero, style: .plain)
        tableView.currentQualityBlock = {[weak self] model in
            self?.currentQualityBlock?(model)
        }
        return tableView
    }()
    
    var qualityArray:[SortedItemModel]?{
        didSet{
            qualityTableview.qualityArray = qualityArray
            let count:CGFloat = CGFloat(qualityArray?.count ?? 0)
            let height = min(AnAnAppDevice.an_screenWidth(), AnAnAppDevice.an_screenHeight())
            qualityTableview.snp.updateConstraints { make in
                make.height.equalTo(64*count)
                make.top.equalTo((height-64*count)/2)
            }
        }
    }
    
    var currentQualityBlock:CurrentSelectQualityBlock?
    
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
        epBgview.addSubview(qualityTableview)
    }
    
    private func setSubviewsFrame() {
        epBgview.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(270)
            make.width.equalTo(270)
        }
        
        qualityTableview.snp.makeConstraints { make in
            make.trailing.width.equalToSuperview()
            make.height.equalTo(64*4)
            make.top.equalTo((AnAnAppDevice.an_screenHeight()-64*4)/2)
        }
    }
    
    func showSelectQualityView(){
        self.layoutIfNeeded()
        self.epBgview.snp.updateConstraints { make in
            make.trailing.equalToSuperview()
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let `self` else {return}
            
            self.layoutIfNeeded()
        }
    }
    
    func hiddenSelectQualityView() {
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
