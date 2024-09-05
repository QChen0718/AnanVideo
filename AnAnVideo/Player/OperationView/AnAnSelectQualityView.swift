//
//  AnAnSelectQualityView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//  选择画质

import UIKit

class AnAnSelectQualityView: UIView {

    //    选择清晰度
    private lazy var qualityTableview:AnAnQualityTableView = {
        let tableView = AnAnQualityTableView(frame: .zero, style: .plain)
        tableView.currentQualityBlock = {[weak self] model in
            self?.currentQualityBlock!(model)
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
        addSubview(qualityTableview)
    }
    
    private func setSubviewsFrame() {
        qualityTableview.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalTo(326)
            make.height.equalTo(64*4)
            make.top.equalTo((AnAnAppDevice.an_screenHeight()-64*4)/2)
        }
    }
}
