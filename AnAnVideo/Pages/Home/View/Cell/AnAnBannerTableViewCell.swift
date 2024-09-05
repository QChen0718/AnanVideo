//
//  AnAnBannerTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit

class AnAnBannerTableViewCell: UITableViewCell {
    private lazy var bannerView:AnAnBannerView = {
        let view = AnAnBannerView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
        setSubviewsFrame()
    }
    var bannerTops:[BannerTopModel]?{
        didSet{
            bannerView.bannerTops = bannerTops
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        contentView.addSubview(bannerView)
    }
    
    private func setSubviewsFrame() {
        bannerView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalToSuperview()
            make.height.equalTo(185)
            make.bottom.equalToSuperview()
        }
    }
}
