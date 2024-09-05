//
//  AnAnBannerView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/18.
//

import UIKit
import JXBanner
import JXPageControl

class AnAnBannerView: UIView {
    
    let anAnBannerCollectionViewCellId = "AnAnBannerCollectionViewCellId"

    private lazy var banner:JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.delegate = self
        banner.dataSource = self
        return banner
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(banner)
        banner.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var bannerTops:[BannerTopModel]?{
        didSet{
            banner.reloadView()
        }
    }
}

extension AnAnBannerView:JXBannerDelegate,JXBannerDataSource{
    
    func jxBanner(numberOfItems banner: JXBannerType) -> Int {
        return self.bannerTops?.count ?? 0
    }
//    注册cell
    func jxBanner(_ banner: JXBannerType) -> JXBannerCellRegister {
        return JXBannerCellRegister(type: AnAnBannerCollectionViewCell.self, reuseIdentifier: anAnBannerCollectionViewCellId)
    }
//    cell 
    func jxBanner(_ banner: JXBannerType, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        let bannerCell = cell as! AnAnBannerCollectionViewCell
        bannerCell.bannerTopModel = self.bannerTops?[index]
        return bannerCell
    }
//    设置定时滚动时长，
    func jxBanner(_ banner: JXBannerType, params: JXBannerParams) -> JXBannerParams {
        return params.timeInterval(5).cycleWay(.forward).isAutoPlay(true)
    }
//    设置item大小间距
    func jxBanner(pageControl banner: JXBannerType, numberOfPages: Int, coverView: UIView, builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        
        let pageControl = JXPageControlScale()
        pageControl.contentMode = .right
        pageControl.activeSize = CGSize(width: 15, height: 6)
        pageControl.inactiveSize = CGSize(width: 6, height: 6)
        pageControl.activeColor = UIColor.white
        pageControl.inactiveColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF,alpha: 0.3)
        pageControl.columnSpacing = 0
        pageControl.isAnimation = true
        builder.pageControl = pageControl
        builder.layout = {
            pageControl.snp.makeConstraints { (maker) in
                maker.left.equalTo(coverView)
                maker.right.equalTo(-10)
                maker.top.equalTo(coverView.snp.bottom).offset(-20)
                maker.height.equalTo(20)
            }
        }
        return builder
    }
    
//    选中item
    func jxBanner(_ banner: JXBannerType, didSelectItemAt index: Int) {
        print("选中的index-->\(index)")
        let bannerTopModel = bannerTops?[index]
        AnAnJumpPageManager.gotToDetailPage(dramaId: bannerTopModel?.targetUrl ?? "")
    }
//    滑动或者定时器滚动
    func jxBanner(_ banner: JXBannerType, center index: Int) {
       
    }
    
    
    
}
